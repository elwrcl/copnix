/*
 * Vulkan implicit layer forces VK 1.4.x (e.g. 1.4.348 via headers)
 */

#include <vulkan/vulkan.h>
#include <vulkan/vk_layer.h>
#include <string.h>

static PFN_vkGetInstanceProcAddr g_next_gipa = NULL;
static PFN_vkGetPhysicalDeviceProperties g_next_gdp = NULL;
static PFN_vkGetPhysicalDeviceProperties2 g_next_gdp2 = NULL;
static PFN_vkGetPhysicalDeviceFeatures g_next_gdf = NULL;
static PFN_vkGetPhysicalDeviceFeatures2 g_next_gdf2 = NULL;

#define HASVK14_API_VERSION VK_MAKE_API_VERSION(0, 1, 4, VK_HEADER_VERSION)
#define INTEL_VENDOR_ID 0x8086

static int is_intel_below_14(uint32_t vendorID, uint32_t apiVersion)
{
    return vendorID == INTEL_VENDOR_ID && VK_API_VERSION_MAJOR(apiVersion) == 1 && VK_API_VERSION_MINOR(apiVersion) < 4;
}

static int is_intel_device(VkPhysicalDevice device)
{
    if (!g_next_gdp) return 0;
    VkPhysicalDeviceProperties props;
    g_next_gdp(device, &props);
    return props.vendorID == INTEL_VENDOR_ID;
}

static void patch_features(VkPhysicalDeviceFeatures *f)
{
    
    f->shaderInt16 = VK_TRUE;
}

VKAPI_ATTR VkResult VKAPI_CALL
HaVK14_EnumerateInstanceVersion(uint32_t *pApiVersion)
{
    *pApiVersion = HASVK14_API_VERSION;
    return VK_SUCCESS;
}

VKAPI_ATTR VkResult VKAPI_CALL
HaVK14_CreateInstance(const VkInstanceCreateInfo *pCreateInfo,
                      const VkAllocationCallbacks *pAllocator,
                      VkInstance *pInstance)
{
    VkLayerInstanceCreateInfo *link =
        (VkLayerInstanceCreateInfo *)pCreateInfo->pNext;

    while (link &&
           !(link->sType == VK_STRUCTURE_TYPE_LOADER_INSTANCE_CREATE_INFO &&
             link->function == VK_LAYER_LINK_INFO))
        link = (VkLayerInstanceCreateInfo *)link->pNext;

    if (!link)
        return VK_ERROR_INITIALIZATION_FAILED;
    g_next_gipa = link->u.pLayerInfo->pfnNextGetInstanceProcAddr;
    link->u.pLayerInfo = link->u.pLayerInfo->pNext;
    PFN_vkCreateInstance next_ci =
        (PFN_vkCreateInstance)g_next_gipa(NULL, "vkCreateInstance");
    VkResult res = next_ci(pCreateInfo, pAllocator, pInstance);
    if (res != VK_SUCCESS)
        return res;
    g_next_gdp = (PFN_vkGetPhysicalDeviceProperties)
        g_next_gipa(*pInstance, "vkGetPhysicalDeviceProperties");
    g_next_gdp2 = (PFN_vkGetPhysicalDeviceProperties2)
        g_next_gipa(*pInstance, "vkGetPhysicalDeviceProperties2");
    if (!g_next_gdp2)
    {
        g_next_gdp2 = (PFN_vkGetPhysicalDeviceProperties2)
            g_next_gipa(*pInstance, "vkGetPhysicalDeviceProperties2KHR");
    }
    g_next_gdf = (PFN_vkGetPhysicalDeviceFeatures)
        g_next_gipa(*pInstance, "vkGetPhysicalDeviceFeatures");
    g_next_gdf2 = (PFN_vkGetPhysicalDeviceFeatures2)
        g_next_gipa(*pInstance, "vkGetPhysicalDeviceFeatures2");
    if (!g_next_gdf2)
    {
        g_next_gdf2 = (PFN_vkGetPhysicalDeviceFeatures2)
            g_next_gipa(*pInstance, "vkGetPhysicalDeviceFeatures2KHR");
    }

    return VK_SUCCESS;
}

VKAPI_ATTR void VKAPI_CALL
HaVK14_GetPhysicalDeviceProperties(VkPhysicalDevice device,
                                   VkPhysicalDeviceProperties *props)
{
    if (g_next_gdp)
        g_next_gdp(device, props);
    if (props && is_intel_below_14(props->vendorID, props->apiVersion))
    {
        props->apiVersion = HASVK14_API_VERSION;
    }
}

VKAPI_ATTR void VKAPI_CALL
HaVK14_GetPhysicalDeviceProperties2(VkPhysicalDevice device,
                                    VkPhysicalDeviceProperties2 *props2)
{
    if (g_next_gdp2)
        g_next_gdp2(device, props2);
    if (!props2)
        return;
    VkPhysicalDeviceProperties *props = &props2->properties;
    if (!is_intel_below_14(props->vendorID, props->apiVersion))
        return;

    props->apiVersion = HASVK14_API_VERSION;
    VkBaseOutStructure *s = (VkBaseOutStructure *)props2->pNext;
    while (s)
    {
        if (s->sType == VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_PROPERTIES)
        {
            VkPhysicalDeviceVulkan12Properties *p12 =
                (VkPhysicalDeviceVulkan12Properties *)s;
            p12->conformanceVersion = (VkConformanceVersion){1, 4, 1, 1};
        }
        if (s->sType == VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_DRIVER_PROPERTIES)
        {
            VkPhysicalDeviceDriverProperties *drv =
                (VkPhysicalDeviceDriverProperties *)s;
            drv->conformanceVersion = (VkConformanceVersion){1, 4, 1, 1};
        }
        s = s->pNext;
    }
}

VKAPI_ATTR void VKAPI_CALL
HaVK14_GetPhysicalDeviceFeatures(VkPhysicalDevice device,
                                  VkPhysicalDeviceFeatures *features)
{
    if (g_next_gdf)
        g_next_gdf(device, features);
    if (features && is_intel_device(device))
        patch_features(features);
}

VKAPI_ATTR void VKAPI_CALL
HaVK14_GetPhysicalDeviceFeatures2(VkPhysicalDevice device,
                                   VkPhysicalDeviceFeatures2 *features2)
{
    if (g_next_gdf2)
        g_next_gdf2(device, features2);
    if (!features2 || !is_intel_device(device))
        return;

    patch_features(&features2->features);

    /* Also patch Vulkan 1.1/1.2 feature structs in pNext chain */
    VkBaseOutStructure *s = (VkBaseOutStructure *)features2->pNext;
    while (s)
    {
        if (s->sType == VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_SHADER_DRAW_PARAMETERS_FEATURES)
        {
            VkPhysicalDeviceShaderDrawParametersFeatures *f =
                (VkPhysicalDeviceShaderDrawParametersFeatures *)s;
            f->shaderDrawParameters = VK_TRUE;
        }
        if (s->sType == VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES)
        {
            VkPhysicalDeviceVulkan12Features *f12 =
                (VkPhysicalDeviceVulkan12Features *)s;
            f12->shaderInt8 = VK_TRUE;
            f12->storageBuffer8BitAccess = VK_TRUE;
            f12->uniformAndStorageBuffer8BitAccess = VK_TRUE;
        }
        s = s->pNext;
    }
}

VKAPI_ATTR PFN_vkVoidFunction VKAPI_CALL
HaVK14_GetInstanceProcAddr(VkInstance instance, const char *pName)
{

#define INTERCEPT(fn)                 \
    if (strcmp(pName, "vk" #fn) == 0) \
        return (PFN_vkVoidFunction)HaVK14_##fn;

    INTERCEPT(GetInstanceProcAddr)
    INTERCEPT(EnumerateInstanceVersion)
    INTERCEPT(CreateInstance)
    INTERCEPT(GetPhysicalDeviceProperties)
    INTERCEPT(GetPhysicalDeviceProperties2)
    INTERCEPT(GetPhysicalDeviceFeatures)
    INTERCEPT(GetPhysicalDeviceFeatures2)

    if (strcmp(pName, "vkGetPhysicalDeviceProperties2KHR") == 0)
        return (PFN_vkVoidFunction)HaVK14_GetPhysicalDeviceProperties2;
    if (strcmp(pName, "vkGetPhysicalDeviceFeatures2KHR") == 0)
        return (PFN_vkVoidFunction)HaVK14_GetPhysicalDeviceFeatures2;

#undef INTERCEPT

    return g_next_gipa ? g_next_gipa(instance, pName) : NULL;
}