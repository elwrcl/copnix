/*
 * Copyright © 2012 - 2014 Intel Corporation
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library. If not, see <http://www.gnu.org/licenses/>.
 *
 */
#ifndef __OCL_INTEGER_H__
#define __OCL_INTEGER_H__

#include "ocl_types.h"

#define CHAR_BIT    8
#define CHAR_MAX    SCHAR_MAX
#define CHAR_MIN    SCHAR_MIN
#define INT_MAX     2147483647
#define INT_MIN     (-2147483647 - 1)
#define LONG_MAX    0x7fffffffffffffffL
#define LONG_MIN    (-0x7fffffffffffffffL - 1)
#define SCHAR_MAX   127
#define SCHAR_MIN   (-127 - 1)
#define SHRT_MAX    32767
#define SHRT_MIN    (-32767 - 1)
#define UCHAR_MAX   255
#define USHRT_MAX   65535
#define UINT_MAX    0xffffffff
#define ULONG_MAX   0xffffffffffffffffUL

OVERLOADABLE char clz(char x);
OVERLOADABLE uchar clz(uchar x);
OVERLOADABLE short clz(short x);
OVERLOADABLE ushort clz(ushort x);
OVERLOADABLE int clz(int x);
OVERLOADABLE uint clz(uint x);
OVERLOADABLE long clz(long x);
OVERLOADABLE ulong clz(ulong x);

char   clz_s8(char);
uchar  clz_u8(uchar);
short  clz_s16(short);
ushort clz_u16(ushort);
int    clz_s32(int);
uint   clz_u32(uint);
long   clz_s64(long);
ulong  clz_u64(ulong);

OVERLOADABLE char ctz(char x);
OVERLOADABLE uchar ctz(uchar x);
OVERLOADABLE short ctz(short x);
OVERLOADABLE ushort ctz(ushort x);
OVERLOADABLE int ctz(int x);
OVERLOADABLE uint ctz(uint x);
OVERLOADABLE long ctz(long x);
OVERLOADABLE ulong ctz(ulong x);

char   ctz_s8(char);
uchar  ctz_u8(uchar);
short  ctz_s16(short);
ushort ctz_u16(ushort);
int    ctz_s32(int);
uint   ctz_u32(uint);
long   ctz_s64(long);
ulong  ctz_u64(ulong);

OVERLOADABLE char popcount(char x);
OVERLOADABLE uchar popcount(uchar x);
OVERLOADABLE short popcount(short x);
OVERLOADABLE ushort popcount(ushort x);
OVERLOADABLE int popcount(int x);
OVERLOADABLE uint popcount(uint x);
OVERLOADABLE long popcount(long x);
OVERLOADABLE ulong popcount(ulong x);

OVERLOADABLE char mul_hi(char x, char y);
OVERLOADABLE uchar mul_hi(uchar x, uchar y);
OVERLOADABLE short mul_hi(short x, short y);
OVERLOADABLE ushort mul_hi(ushort x, ushort y);
OVERLOADABLE int mul_hi(int x, int y);
OVERLOADABLE uint mul_hi(uint x, uint y);
OVERLOADABLE long mul_hi(long x, long y);
OVERLOADABLE ulong mul_hi(ulong x, ulong y);

#define SDEF(TYPE)        \
OVERLOADABLE TYPE add_sat(TYPE x, TYPE y);   \
OVERLOADABLE TYPE sub_sat(TYPE x, TYPE y);
SDEF(char);
SDEF(short);
SDEF(int);
SDEF(long);
#undef SDEF
#define UDEF(TYPE)  \
OVERLOADABLE TYPE add_sat(TYPE x, TYPE y);   \
OVERLOADABLE TYPE sub_sat(TYPE x, TYPE y);
UDEF(uchar);
UDEF(ushort);
UDEF(uint);
UDEF(ulong);
#undef UDEF

#define DEF(type) OVERLOADABLE type mad_hi(type a, type b, type c);
DEF(char)
DEF(uchar)
DEF(short)
DEF(ushort)
DEF(int)
DEF(uint)
DEF(long)
DEF(ulong)
#undef DEF

OVERLOADABLE int mul24(int a, int b);
OVERLOADABLE uint mul24(uint a, uint b);

OVERLOADABLE int mad24(int a, int b, int c);
OVERLOADABLE uint mad24(uint a, uint b, uint c);

OVERLOADABLE char mad_sat(char a, char b, char c) ;
OVERLOADABLE uchar mad_sat(uchar a, uchar b, uchar c);
OVERLOADABLE short mad_sat(short a, short b, short c);
OVERLOADABLE ushort mad_sat(ushort a, ushort b, ushort c);
OVERLOADABLE int mad_sat(int a, int b, int c);
OVERLOADABLE uint mad_sat(uint a, uint b, uint c);
OVERLOADABLE long mad_sat(long a, long b, long c);
OVERLOADABLE ulong mad_sat(ulong a, ulong b, ulong c);

#define DEF(type, m) OVERLOADABLE type rotate(type x, type y);
DEF(char, 7)
DEF(uchar, 7)
DEF(short, 15)
DEF(ushort, 15)
DEF(int, 31)
DEF(uint, 31)
DEF(long, 63)
DEF(ulong, 63)
#undef DEF

OVERLOADABLE short upsample(char hi, uchar lo);
OVERLOADABLE ushort upsample(uchar hi, uchar lo);
OVERLOADABLE int upsample(short hi, ushort lo);
OVERLOADABLE uint upsample(ushort hi, ushort lo);
OVERLOADABLE long upsample(int hi, uint lo);
OVERLOADABLE ulong upsample(uint hi, uint lo);

#define DEC DEF(char); DEF(uchar); DEF(short); DEF(ushort)
#define DEF(type) OVERLOADABLE type hadd(type x, type y);
DEC
#undef DEF
#define DEF(type) OVERLOADABLE type rhadd(type x, type y);
DEC
#undef DEF
#undef DEC
OVERLOADABLE int hadd(int x, int y);
OVERLOADABLE uint hadd(uint x, uint y);
OVERLOADABLE int rhadd(int x, int y);
OVERLOADABLE uint rhadd(uint x, uint y);
OVERLOADABLE long hadd(long x, long y);
OVERLOADABLE ulong hadd(ulong x, ulong y);
OVERLOADABLE long rhadd(long x, long y);
OVERLOADABLE ulong rhadd(ulong x, ulong y);

#define DEC(TYPE) OVERLOADABLE u##TYPE abs(TYPE x);
DEC(int)
DEC(short)
DEC(char)
#undef DEC
OVERLOADABLE ulong abs(long x);
/* For unsigned types, do nothing. */
#define DEC(TYPE) OVERLOADABLE TYPE abs(TYPE x);
DEC(uint)
DEC(ushort)
DEC(uchar)
DEC(ulong)
#undef DEC

/* Char and short type abs diff */
/* promote char and short to int and will be no module overflow */
#define DEC(TYPE, UTYPE) OVERLOADABLE UTYPE abs_diff(TYPE x, TYPE y);
DEC(char, uchar)
DEC(uchar, uchar)
DEC(short, ushort)
DEC(ushort, ushort)
#undef DEC

OVERLOADABLE uint abs_diff (uint x, uint y);
OVERLOADABLE uint abs_diff (int x, int y);
OVERLOADABLE ulong abs_diff (long x, long y);
OVERLOADABLE ulong abs_diff (ulong x, ulong y);


#define DECL_MIN_MAX_CLAMP(TYPE) \
OVERLOADABLE TYPE max(TYPE a, TYPE b);  \
OVERLOADABLE TYPE min(TYPE a, TYPE b);  \
OVERLOADABLE TYPE clamp(TYPE v, TYPE l, TYPE u);
DECL_MIN_MAX_CLAMP(int)
DECL_MIN_MAX_CLAMP(short)
DECL_MIN_MAX_CLAMP(char)
DECL_MIN_MAX_CLAMP(uint)
DECL_MIN_MAX_CLAMP(unsigned short)
DECL_MIN_MAX_CLAMP(unsigned char)
DECL_MIN_MAX_CLAMP(long)
DECL_MIN_MAX_CLAMP(ulong)
#undef DECL_MIN_MAX_CLAMP
//Begin from this part is autogenerated.
//Don't modify it manually.
//integer builtin functions
//ugentype abs (gentype x)

OVERLOADABLE uchar2 abs (char2 param0);
OVERLOADABLE uchar3 abs (char3 param0);
OVERLOADABLE uchar4 abs (char4 param0);
OVERLOADABLE uchar8 abs (char8 param0);
OVERLOADABLE uchar16 abs (char16 param0);
OVERLOADABLE ushort2 abs (short2 param0);
OVERLOADABLE ushort3 abs (short3 param0);
OVERLOADABLE ushort4 abs (short4 param0);
OVERLOADABLE ushort8 abs (short8 param0);
OVERLOADABLE ushort16 abs (short16 param0);
OVERLOADABLE uint2 abs (int2 param0);
OVERLOADABLE uint3 abs (int3 param0);
OVERLOADABLE uint4 abs (int4 param0);
OVERLOADABLE uint8 abs (int8 param0);
OVERLOADABLE uint16 abs (int16 param0);
OVERLOADABLE ulong2 abs (long2 param0);
OVERLOADABLE ulong3 abs (long3 param0);
OVERLOADABLE ulong4 abs (long4 param0);
OVERLOADABLE ulong8 abs (long8 param0);
OVERLOADABLE ulong16 abs (long16 param0);
OVERLOADABLE uchar2 abs (uchar2 param0);
OVERLOADABLE uchar3 abs (uchar3 param0);
OVERLOADABLE uchar4 abs (uchar4 param0);
OVERLOADABLE uchar8 abs (uchar8 param0);
OVERLOADABLE uchar16 abs (uchar16 param0);
OVERLOADABLE ushort2 abs (ushort2 param0);
OVERLOADABLE ushort3 abs (ushort3 param0);
OVERLOADABLE ushort4 abs (ushort4 param0);
OVERLOADABLE ushort8 abs (ushort8 param0);
OVERLOADABLE ushort16 abs (ushort16 param0);
OVERLOADABLE uint2 abs (uint2 param0);
OVERLOADABLE uint3 abs (uint3 param0);
OVERLOADABLE uint4 abs (uint4 param0);
OVERLOADABLE uint8 abs (uint8 param0);
OVERLOADABLE uint16 abs (uint16 param0);
OVERLOADABLE ulong2 abs (ulong2 param0);
OVERLOADABLE ulong3 abs (ulong3 param0);
OVERLOADABLE ulong4 abs (ulong4 param0);
OVERLOADABLE ulong8 abs (ulong8 param0);
OVERLOADABLE ulong16 abs (ulong16 param0);

//ugentype abs_diff (gentype x, gentype y)

OVERLOADABLE uchar2 abs_diff (char2 param0, char2 param1);
OVERLOADABLE uchar3 abs_diff (char3 param0, char3 param1);
OVERLOADABLE uchar4 abs_diff (char4 param0, char4 param1);
OVERLOADABLE uchar8 abs_diff (char8 param0, char8 param1);
OVERLOADABLE uchar16 abs_diff (char16 param0, char16 param1);
OVERLOADABLE ushort2 abs_diff (short2 param0, short2 param1);
OVERLOADABLE ushort3 abs_diff (short3 param0, short3 param1);
OVERLOADABLE ushort4 abs_diff (short4 param0, short4 param1);
OVERLOADABLE ushort8 abs_diff (short8 param0, short8 param1);
OVERLOADABLE ushort16 abs_diff (short16 param0, short16 param1);
OVERLOADABLE uint2 abs_diff (int2 param0, int2 param1);
OVERLOADABLE uint3 abs_diff (int3 param0, int3 param1);
OVERLOADABLE uint4 abs_diff (int4 param0, int4 param1);
OVERLOADABLE uint8 abs_diff (int8 param0, int8 param1);
OVERLOADABLE uint16 abs_diff (int16 param0, int16 param1);
OVERLOADABLE ulong2 abs_diff (long2 param0, long2 param1);
OVERLOADABLE ulong3 abs_diff (long3 param0, long3 param1);
OVERLOADABLE ulong4 abs_diff (long4 param0, long4 param1);
OVERLOADABLE ulong8 abs_diff (long8 param0, long8 param1);
OVERLOADABLE ulong16 abs_diff (long16 param0, long16 param1);
OVERLOADABLE uchar2 abs_diff (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 abs_diff (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 abs_diff (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 abs_diff (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 abs_diff (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 abs_diff (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 abs_diff (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 abs_diff (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 abs_diff (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 abs_diff (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 abs_diff (uint2 param0, uint2 param1);
OVERLOADABLE uint3 abs_diff (uint3 param0, uint3 param1);
OVERLOADABLE uint4 abs_diff (uint4 param0, uint4 param1);
OVERLOADABLE uint8 abs_diff (uint8 param0, uint8 param1);
OVERLOADABLE uint16 abs_diff (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 abs_diff (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 abs_diff (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 abs_diff (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 abs_diff (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 abs_diff (ulong16 param0, ulong16 param1);

//gentype add_sat (gentype x,  gentype y)

OVERLOADABLE char2 add_sat (char2 param0, char2 param1);
OVERLOADABLE char3 add_sat (char3 param0, char3 param1);
OVERLOADABLE char4 add_sat (char4 param0, char4 param1);
OVERLOADABLE char8 add_sat (char8 param0, char8 param1);
OVERLOADABLE char16 add_sat (char16 param0, char16 param1);
OVERLOADABLE short2 add_sat (short2 param0, short2 param1);
OVERLOADABLE short3 add_sat (short3 param0, short3 param1);
OVERLOADABLE short4 add_sat (short4 param0, short4 param1);
OVERLOADABLE short8 add_sat (short8 param0, short8 param1);
OVERLOADABLE short16 add_sat (short16 param0, short16 param1);
OVERLOADABLE int2 add_sat (int2 param0, int2 param1);
OVERLOADABLE int3 add_sat (int3 param0, int3 param1);
OVERLOADABLE int4 add_sat (int4 param0, int4 param1);
OVERLOADABLE int8 add_sat (int8 param0, int8 param1);
OVERLOADABLE int16 add_sat (int16 param0, int16 param1);
OVERLOADABLE long2 add_sat (long2 param0, long2 param1);
OVERLOADABLE long3 add_sat (long3 param0, long3 param1);
OVERLOADABLE long4 add_sat (long4 param0, long4 param1);
OVERLOADABLE long8 add_sat (long8 param0, long8 param1);
OVERLOADABLE long16 add_sat (long16 param0, long16 param1);
OVERLOADABLE uchar2 add_sat (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 add_sat (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 add_sat (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 add_sat (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 add_sat (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 add_sat (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 add_sat (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 add_sat (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 add_sat (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 add_sat (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 add_sat (uint2 param0, uint2 param1);
OVERLOADABLE uint3 add_sat (uint3 param0, uint3 param1);
OVERLOADABLE uint4 add_sat (uint4 param0, uint4 param1);
OVERLOADABLE uint8 add_sat (uint8 param0, uint8 param1);
OVERLOADABLE uint16 add_sat (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 add_sat (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 add_sat (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 add_sat (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 add_sat (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 add_sat (ulong16 param0, ulong16 param1);

//gentype hadd (gentype x,  gentype y)

OVERLOADABLE char2 hadd (char2 param0, char2 param1);
OVERLOADABLE char3 hadd (char3 param0, char3 param1);
OVERLOADABLE char4 hadd (char4 param0, char4 param1);
OVERLOADABLE char8 hadd (char8 param0, char8 param1);
OVERLOADABLE char16 hadd (char16 param0, char16 param1);
OVERLOADABLE short2 hadd (short2 param0, short2 param1);
OVERLOADABLE short3 hadd (short3 param0, short3 param1);
OVERLOADABLE short4 hadd (short4 param0, short4 param1);
OVERLOADABLE short8 hadd (short8 param0, short8 param1);
OVERLOADABLE short16 hadd (short16 param0, short16 param1);
OVERLOADABLE int2 hadd (int2 param0, int2 param1);
OVERLOADABLE int3 hadd (int3 param0, int3 param1);
OVERLOADABLE int4 hadd (int4 param0, int4 param1);
OVERLOADABLE int8 hadd (int8 param0, int8 param1);
OVERLOADABLE int16 hadd (int16 param0, int16 param1);
OVERLOADABLE long2 hadd (long2 param0, long2 param1);
OVERLOADABLE long3 hadd (long3 param0, long3 param1);
OVERLOADABLE long4 hadd (long4 param0, long4 param1);
OVERLOADABLE long8 hadd (long8 param0, long8 param1);
OVERLOADABLE long16 hadd (long16 param0, long16 param1);
OVERLOADABLE uchar2 hadd (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 hadd (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 hadd (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 hadd (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 hadd (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 hadd (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 hadd (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 hadd (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 hadd (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 hadd (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 hadd (uint2 param0, uint2 param1);
OVERLOADABLE uint3 hadd (uint3 param0, uint3 param1);
OVERLOADABLE uint4 hadd (uint4 param0, uint4 param1);
OVERLOADABLE uint8 hadd (uint8 param0, uint8 param1);
OVERLOADABLE uint16 hadd (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 hadd (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 hadd (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 hadd (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 hadd (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 hadd (ulong16 param0, ulong16 param1);

//gentype rhadd (gentype x, gentype y)

OVERLOADABLE char2 rhadd (char2 param0, char2 param1);
OVERLOADABLE char3 rhadd (char3 param0, char3 param1);
OVERLOADABLE char4 rhadd (char4 param0, char4 param1);
OVERLOADABLE char8 rhadd (char8 param0, char8 param1);
OVERLOADABLE char16 rhadd (char16 param0, char16 param1);
OVERLOADABLE short2 rhadd (short2 param0, short2 param1);
OVERLOADABLE short3 rhadd (short3 param0, short3 param1);
OVERLOADABLE short4 rhadd (short4 param0, short4 param1);
OVERLOADABLE short8 rhadd (short8 param0, short8 param1);
OVERLOADABLE short16 rhadd (short16 param0, short16 param1);
OVERLOADABLE int2 rhadd (int2 param0, int2 param1);
OVERLOADABLE int3 rhadd (int3 param0, int3 param1);
OVERLOADABLE int4 rhadd (int4 param0, int4 param1);
OVERLOADABLE int8 rhadd (int8 param0, int8 param1);
OVERLOADABLE int16 rhadd (int16 param0, int16 param1);
OVERLOADABLE long2 rhadd (long2 param0, long2 param1);
OVERLOADABLE long3 rhadd (long3 param0, long3 param1);
OVERLOADABLE long4 rhadd (long4 param0, long4 param1);
OVERLOADABLE long8 rhadd (long8 param0, long8 param1);
OVERLOADABLE long16 rhadd (long16 param0, long16 param1);
OVERLOADABLE uchar2 rhadd (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 rhadd (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 rhadd (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 rhadd (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 rhadd (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 rhadd (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 rhadd (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 rhadd (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 rhadd (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 rhadd (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 rhadd (uint2 param0, uint2 param1);
OVERLOADABLE uint3 rhadd (uint3 param0, uint3 param1);
OVERLOADABLE uint4 rhadd (uint4 param0, uint4 param1);
OVERLOADABLE uint8 rhadd (uint8 param0, uint8 param1);
OVERLOADABLE uint16 rhadd (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 rhadd (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 rhadd (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 rhadd (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 rhadd (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 rhadd (ulong16 param0, ulong16 param1);

//gentype clamp (gentype x, gentype minval, gentype maxval)

OVERLOADABLE char2 clamp (char2 param0, char2 param1, char2 param2);
OVERLOADABLE char3 clamp (char3 param0, char3 param1, char3 param2);
OVERLOADABLE char4 clamp (char4 param0, char4 param1, char4 param2);
OVERLOADABLE char8 clamp (char8 param0, char8 param1, char8 param2);
OVERLOADABLE char16 clamp (char16 param0, char16 param1, char16 param2);
OVERLOADABLE short2 clamp (short2 param0, short2 param1, short2 param2);
OVERLOADABLE short3 clamp (short3 param0, short3 param1, short3 param2);
OVERLOADABLE short4 clamp (short4 param0, short4 param1, short4 param2);
OVERLOADABLE short8 clamp (short8 param0, short8 param1, short8 param2);
OVERLOADABLE short16 clamp (short16 param0, short16 param1, short16 param2);
OVERLOADABLE int2 clamp (int2 param0, int2 param1, int2 param2);
OVERLOADABLE int3 clamp (int3 param0, int3 param1, int3 param2);
OVERLOADABLE int4 clamp (int4 param0, int4 param1, int4 param2);
OVERLOADABLE int8 clamp (int8 param0, int8 param1, int8 param2);
OVERLOADABLE int16 clamp (int16 param0, int16 param1, int16 param2);
OVERLOADABLE long2 clamp (long2 param0, long2 param1, long2 param2);
OVERLOADABLE long3 clamp (long3 param0, long3 param1, long3 param2);
OVERLOADABLE long4 clamp (long4 param0, long4 param1, long4 param2);
OVERLOADABLE long8 clamp (long8 param0, long8 param1, long8 param2);
OVERLOADABLE long16 clamp (long16 param0, long16 param1, long16 param2);
OVERLOADABLE uchar2 clamp (uchar2 param0, uchar2 param1, uchar2 param2);
OVERLOADABLE uchar3 clamp (uchar3 param0, uchar3 param1, uchar3 param2);
OVERLOADABLE uchar4 clamp (uchar4 param0, uchar4 param1, uchar4 param2);
OVERLOADABLE uchar8 clamp (uchar8 param0, uchar8 param1, uchar8 param2);
OVERLOADABLE uchar16 clamp (uchar16 param0, uchar16 param1, uchar16 param2);
OVERLOADABLE ushort2 clamp (ushort2 param0, ushort2 param1, ushort2 param2);
OVERLOADABLE ushort3 clamp (ushort3 param0, ushort3 param1, ushort3 param2);
OVERLOADABLE ushort4 clamp (ushort4 param0, ushort4 param1, ushort4 param2);
OVERLOADABLE ushort8 clamp (ushort8 param0, ushort8 param1, ushort8 param2);
OVERLOADABLE ushort16 clamp (ushort16 param0, ushort16 param1, ushort16 param2);
OVERLOADABLE uint2 clamp (uint2 param0, uint2 param1, uint2 param2);
OVERLOADABLE uint3 clamp (uint3 param0, uint3 param1, uint3 param2);
OVERLOADABLE uint4 clamp (uint4 param0, uint4 param1, uint4 param2);
OVERLOADABLE uint8 clamp (uint8 param0, uint8 param1, uint8 param2);
OVERLOADABLE uint16 clamp (uint16 param0, uint16 param1, uint16 param2);
OVERLOADABLE ulong2 clamp (ulong2 param0, ulong2 param1, ulong2 param2);
OVERLOADABLE ulong3 clamp (ulong3 param0, ulong3 param1, ulong3 param2);
OVERLOADABLE ulong4 clamp (ulong4 param0, ulong4 param1, ulong4 param2);
OVERLOADABLE ulong8 clamp (ulong8 param0, ulong8 param1, ulong8 param2);
OVERLOADABLE ulong16 clamp (ulong16 param0, ulong16 param1, ulong16 param2);

//gentype clamp (gentype x, sgentype minval, sgentype maxval)

OVERLOADABLE char2 clamp (char2 param0, char param1, char param2);
OVERLOADABLE char3 clamp (char3 param0, char param1, char param2);
OVERLOADABLE char4 clamp (char4 param0, char param1, char param2);
OVERLOADABLE char8 clamp (char8 param0, char param1, char param2);
OVERLOADABLE char16 clamp (char16 param0, char param1, char param2);
OVERLOADABLE short2 clamp (short2 param0, short param1, short param2);
OVERLOADABLE short3 clamp (short3 param0, short param1, short param2);
OVERLOADABLE short4 clamp (short4 param0, short param1, short param2);
OVERLOADABLE short8 clamp (short8 param0, short param1, short param2);
OVERLOADABLE short16 clamp (short16 param0, short param1, short param2);
OVERLOADABLE int2 clamp (int2 param0, int param1, int param2);
OVERLOADABLE int3 clamp (int3 param0, int param1, int param2);
OVERLOADABLE int4 clamp (int4 param0, int param1, int param2);
OVERLOADABLE int8 clamp (int8 param0, int param1, int param2);
OVERLOADABLE int16 clamp (int16 param0, int param1, int param2);
OVERLOADABLE long2 clamp (long2 param0, long param1, long param2);
OVERLOADABLE long3 clamp (long3 param0, long param1, long param2);
OVERLOADABLE long4 clamp (long4 param0, long param1, long param2);
OVERLOADABLE long8 clamp (long8 param0, long param1, long param2);
OVERLOADABLE long16 clamp (long16 param0, long param1, long param2);
OVERLOADABLE uchar2 clamp (uchar2 param0, uchar param1, uchar param2);
OVERLOADABLE uchar3 clamp (uchar3 param0, uchar param1, uchar param2);
OVERLOADABLE uchar4 clamp (uchar4 param0, uchar param1, uchar param2);
OVERLOADABLE uchar8 clamp (uchar8 param0, uchar param1, uchar param2);
OVERLOADABLE uchar16 clamp (uchar16 param0, uchar param1, uchar param2);
OVERLOADABLE ushort2 clamp (ushort2 param0, ushort param1, ushort param2);
OVERLOADABLE ushort3 clamp (ushort3 param0, ushort param1, ushort param2);
OVERLOADABLE ushort4 clamp (ushort4 param0, ushort param1, ushort param2);
OVERLOADABLE ushort8 clamp (ushort8 param0, ushort param1, ushort param2);
OVERLOADABLE ushort16 clamp (ushort16 param0, ushort param1, ushort param2);
OVERLOADABLE uint2 clamp (uint2 param0, uint param1, uint param2);
OVERLOADABLE uint3 clamp (uint3 param0, uint param1, uint param2);
OVERLOADABLE uint4 clamp (uint4 param0, uint param1, uint param2);
OVERLOADABLE uint8 clamp (uint8 param0, uint param1, uint param2);
OVERLOADABLE uint16 clamp (uint16 param0, uint param1, uint param2);
OVERLOADABLE ulong2 clamp (ulong2 param0, ulong param1, ulong param2);
OVERLOADABLE ulong3 clamp (ulong3 param0, ulong param1, ulong param2);
OVERLOADABLE ulong4 clamp (ulong4 param0, ulong param1, ulong param2);
OVERLOADABLE ulong8 clamp (ulong8 param0, ulong param1, ulong param2);
OVERLOADABLE ulong16 clamp (ulong16 param0, ulong param1, ulong param2);

//gentype clz (gentype x)

OVERLOADABLE char2 clz (char2 param0);
OVERLOADABLE char3 clz (char3 param0);
OVERLOADABLE char4 clz (char4 param0);
OVERLOADABLE char8 clz (char8 param0);
OVERLOADABLE char16 clz (char16 param0);
OVERLOADABLE short2 clz (short2 param0);
OVERLOADABLE short3 clz (short3 param0);
OVERLOADABLE short4 clz (short4 param0);
OVERLOADABLE short8 clz (short8 param0);
OVERLOADABLE short16 clz (short16 param0);
OVERLOADABLE int2 clz (int2 param0);
OVERLOADABLE int3 clz (int3 param0);
OVERLOADABLE int4 clz (int4 param0);
OVERLOADABLE int8 clz (int8 param0);
OVERLOADABLE int16 clz (int16 param0);
OVERLOADABLE long2 clz (long2 param0);
OVERLOADABLE long3 clz (long3 param0);
OVERLOADABLE long4 clz (long4 param0);
OVERLOADABLE long8 clz (long8 param0);
OVERLOADABLE long16 clz (long16 param0);
OVERLOADABLE uchar2 clz (uchar2 param0);
OVERLOADABLE uchar3 clz (uchar3 param0);
OVERLOADABLE uchar4 clz (uchar4 param0);
OVERLOADABLE uchar8 clz (uchar8 param0);
OVERLOADABLE uchar16 clz (uchar16 param0);
OVERLOADABLE ushort2 clz (ushort2 param0);
OVERLOADABLE ushort3 clz (ushort3 param0);
OVERLOADABLE ushort4 clz (ushort4 param0);
OVERLOADABLE ushort8 clz (ushort8 param0);
OVERLOADABLE ushort16 clz (ushort16 param0);
OVERLOADABLE uint2 clz (uint2 param0);
OVERLOADABLE uint3 clz (uint3 param0);
OVERLOADABLE uint4 clz (uint4 param0);
OVERLOADABLE uint8 clz (uint8 param0);
OVERLOADABLE uint16 clz (uint16 param0);
OVERLOADABLE ulong2 clz (ulong2 param0);
OVERLOADABLE ulong3 clz (ulong3 param0);
OVERLOADABLE ulong4 clz (ulong4 param0);
OVERLOADABLE ulong8 clz (ulong8 param0);
OVERLOADABLE ulong16 clz (ulong16 param0);

//gentype ctz (gentype x)

OVERLOADABLE char2 ctz (char2 param0);
OVERLOADABLE char3 ctz (char3 param0);
OVERLOADABLE char4 ctz (char4 param0);
OVERLOADABLE char8 ctz (char8 param0);
OVERLOADABLE char16 ctz (char16 param0);
OVERLOADABLE short2 ctz (short2 param0);
OVERLOADABLE short3 ctz (short3 param0);
OVERLOADABLE short4 ctz (short4 param0);
OVERLOADABLE short8 ctz (short8 param0);
OVERLOADABLE short16 ctz (short16 param0);
OVERLOADABLE int2 ctz (int2 param0);
OVERLOADABLE int3 ctz (int3 param0);
OVERLOADABLE int4 ctz (int4 param0);
OVERLOADABLE int8 ctz (int8 param0);
OVERLOADABLE int16 ctz (int16 param0);
OVERLOADABLE long2 ctz (long2 param0);
OVERLOADABLE long3 ctz (long3 param0);
OVERLOADABLE long4 ctz (long4 param0);
OVERLOADABLE long8 ctz (long8 param0);
OVERLOADABLE long16 ctz (long16 param0);
OVERLOADABLE uchar2 ctz (uchar2 param0);
OVERLOADABLE uchar3 ctz (uchar3 param0);
OVERLOADABLE uchar4 ctz (uchar4 param0);
OVERLOADABLE uchar8 ctz (uchar8 param0);
OVERLOADABLE uchar16 ctz (uchar16 param0);
OVERLOADABLE ushort2 ctz (ushort2 param0);
OVERLOADABLE ushort3 ctz (ushort3 param0);
OVERLOADABLE ushort4 ctz (ushort4 param0);
OVERLOADABLE ushort8 ctz (ushort8 param0);
OVERLOADABLE ushort16 ctz (ushort16 param0);
OVERLOADABLE uint2 ctz (uint2 param0);
OVERLOADABLE uint3 ctz (uint3 param0);
OVERLOADABLE uint4 ctz (uint4 param0);
OVERLOADABLE uint8 ctz (uint8 param0);
OVERLOADABLE uint16 ctz (uint16 param0);
OVERLOADABLE ulong2 ctz (ulong2 param0);
OVERLOADABLE ulong3 ctz (ulong3 param0);
OVERLOADABLE ulong4 ctz (ulong4 param0);
OVERLOADABLE ulong8 ctz (ulong8 param0);
OVERLOADABLE ulong16 ctz (ulong16 param0);

//gentype mad_hi (gentype a, gentype b, gentype c)

OVERLOADABLE char2 mad_hi (char2 param0, char2 param1, char2 param2);
OVERLOADABLE char3 mad_hi (char3 param0, char3 param1, char3 param2);
OVERLOADABLE char4 mad_hi (char4 param0, char4 param1, char4 param2);
OVERLOADABLE char8 mad_hi (char8 param0, char8 param1, char8 param2);
OVERLOADABLE char16 mad_hi (char16 param0, char16 param1, char16 param2);
OVERLOADABLE short2 mad_hi (short2 param0, short2 param1, short2 param2);
OVERLOADABLE short3 mad_hi (short3 param0, short3 param1, short3 param2);
OVERLOADABLE short4 mad_hi (short4 param0, short4 param1, short4 param2);
OVERLOADABLE short8 mad_hi (short8 param0, short8 param1, short8 param2);
OVERLOADABLE short16 mad_hi (short16 param0, short16 param1, short16 param2);
OVERLOADABLE int2 mad_hi (int2 param0, int2 param1, int2 param2);
OVERLOADABLE int3 mad_hi (int3 param0, int3 param1, int3 param2);
OVERLOADABLE int4 mad_hi (int4 param0, int4 param1, int4 param2);
OVERLOADABLE int8 mad_hi (int8 param0, int8 param1, int8 param2);
OVERLOADABLE int16 mad_hi (int16 param0, int16 param1, int16 param2);
OVERLOADABLE long2 mad_hi (long2 param0, long2 param1, long2 param2);
OVERLOADABLE long3 mad_hi (long3 param0, long3 param1, long3 param2);
OVERLOADABLE long4 mad_hi (long4 param0, long4 param1, long4 param2);
OVERLOADABLE long8 mad_hi (long8 param0, long8 param1, long8 param2);
OVERLOADABLE long16 mad_hi (long16 param0, long16 param1, long16 param2);
OVERLOADABLE uchar2 mad_hi (uchar2 param0, uchar2 param1, uchar2 param2);
OVERLOADABLE uchar3 mad_hi (uchar3 param0, uchar3 param1, uchar3 param2);
OVERLOADABLE uchar4 mad_hi (uchar4 param0, uchar4 param1, uchar4 param2);
OVERLOADABLE uchar8 mad_hi (uchar8 param0, uchar8 param1, uchar8 param2);
OVERLOADABLE uchar16 mad_hi (uchar16 param0, uchar16 param1, uchar16 param2);
OVERLOADABLE ushort2 mad_hi (ushort2 param0, ushort2 param1, ushort2 param2);
OVERLOADABLE ushort3 mad_hi (ushort3 param0, ushort3 param1, ushort3 param2);
OVERLOADABLE ushort4 mad_hi (ushort4 param0, ushort4 param1, ushort4 param2);
OVERLOADABLE ushort8 mad_hi (ushort8 param0, ushort8 param1, ushort8 param2);
OVERLOADABLE ushort16 mad_hi (ushort16 param0, ushort16 param1, ushort16 param2);
OVERLOADABLE uint2 mad_hi (uint2 param0, uint2 param1, uint2 param2);
OVERLOADABLE uint3 mad_hi (uint3 param0, uint3 param1, uint3 param2);
OVERLOADABLE uint4 mad_hi (uint4 param0, uint4 param1, uint4 param2);
OVERLOADABLE uint8 mad_hi (uint8 param0, uint8 param1, uint8 param2);
OVERLOADABLE uint16 mad_hi (uint16 param0, uint16 param1, uint16 param2);
OVERLOADABLE ulong2 mad_hi (ulong2 param0, ulong2 param1, ulong2 param2);
OVERLOADABLE ulong3 mad_hi (ulong3 param0, ulong3 param1, ulong3 param2);
OVERLOADABLE ulong4 mad_hi (ulong4 param0, ulong4 param1, ulong4 param2);
OVERLOADABLE ulong8 mad_hi (ulong8 param0, ulong8 param1, ulong8 param2);
OVERLOADABLE ulong16 mad_hi (ulong16 param0, ulong16 param1, ulong16 param2);

//gentype mad_sat (gentype a, gentype b, gentype c)

OVERLOADABLE char2 mad_sat (char2 param0, char2 param1, char2 param2);
OVERLOADABLE char3 mad_sat (char3 param0, char3 param1, char3 param2);
OVERLOADABLE char4 mad_sat (char4 param0, char4 param1, char4 param2);
OVERLOADABLE char8 mad_sat (char8 param0, char8 param1, char8 param2);
OVERLOADABLE char16 mad_sat (char16 param0, char16 param1, char16 param2);
OVERLOADABLE short2 mad_sat (short2 param0, short2 param1, short2 param2);
OVERLOADABLE short3 mad_sat (short3 param0, short3 param1, short3 param2);
OVERLOADABLE short4 mad_sat (short4 param0, short4 param1, short4 param2);
OVERLOADABLE short8 mad_sat (short8 param0, short8 param1, short8 param2);
OVERLOADABLE short16 mad_sat (short16 param0, short16 param1, short16 param2);
OVERLOADABLE int2 mad_sat (int2 param0, int2 param1, int2 param2);
OVERLOADABLE int3 mad_sat (int3 param0, int3 param1, int3 param2);
OVERLOADABLE int4 mad_sat (int4 param0, int4 param1, int4 param2);
OVERLOADABLE int8 mad_sat (int8 param0, int8 param1, int8 param2);
OVERLOADABLE int16 mad_sat (int16 param0, int16 param1, int16 param2);
OVERLOADABLE long2 mad_sat (long2 param0, long2 param1, long2 param2);
OVERLOADABLE long3 mad_sat (long3 param0, long3 param1, long3 param2);
OVERLOADABLE long4 mad_sat (long4 param0, long4 param1, long4 param2);
OVERLOADABLE long8 mad_sat (long8 param0, long8 param1, long8 param2);
OVERLOADABLE long16 mad_sat (long16 param0, long16 param1, long16 param2);
OVERLOADABLE uchar2 mad_sat (uchar2 param0, uchar2 param1, uchar2 param2);
OVERLOADABLE uchar3 mad_sat (uchar3 param0, uchar3 param1, uchar3 param2);
OVERLOADABLE uchar4 mad_sat (uchar4 param0, uchar4 param1, uchar4 param2);
OVERLOADABLE uchar8 mad_sat (uchar8 param0, uchar8 param1, uchar8 param2);
OVERLOADABLE uchar16 mad_sat (uchar16 param0, uchar16 param1, uchar16 param2);
OVERLOADABLE ushort2 mad_sat (ushort2 param0, ushort2 param1, ushort2 param2);
OVERLOADABLE ushort3 mad_sat (ushort3 param0, ushort3 param1, ushort3 param2);
OVERLOADABLE ushort4 mad_sat (ushort4 param0, ushort4 param1, ushort4 param2);
OVERLOADABLE ushort8 mad_sat (ushort8 param0, ushort8 param1, ushort8 param2);
OVERLOADABLE ushort16 mad_sat (ushort16 param0, ushort16 param1, ushort16 param2);
OVERLOADABLE uint2 mad_sat (uint2 param0, uint2 param1, uint2 param2);
OVERLOADABLE uint3 mad_sat (uint3 param0, uint3 param1, uint3 param2);
OVERLOADABLE uint4 mad_sat (uint4 param0, uint4 param1, uint4 param2);
OVERLOADABLE uint8 mad_sat (uint8 param0, uint8 param1, uint8 param2);
OVERLOADABLE uint16 mad_sat (uint16 param0, uint16 param1, uint16 param2);
OVERLOADABLE ulong2 mad_sat (ulong2 param0, ulong2 param1, ulong2 param2);
OVERLOADABLE ulong3 mad_sat (ulong3 param0, ulong3 param1, ulong3 param2);
OVERLOADABLE ulong4 mad_sat (ulong4 param0, ulong4 param1, ulong4 param2);
OVERLOADABLE ulong8 mad_sat (ulong8 param0, ulong8 param1, ulong8 param2);
OVERLOADABLE ulong16 mad_sat (ulong16 param0, ulong16 param1, ulong16 param2);

//gentype max (gentype x,  gentype y)

OVERLOADABLE char2 max (char2 param0, char2 param1);
OVERLOADABLE char3 max (char3 param0, char3 param1);
OVERLOADABLE char4 max (char4 param0, char4 param1);
OVERLOADABLE char8 max (char8 param0, char8 param1);
OVERLOADABLE char16 max (char16 param0, char16 param1);
OVERLOADABLE short2 max (short2 param0, short2 param1);
OVERLOADABLE short3 max (short3 param0, short3 param1);
OVERLOADABLE short4 max (short4 param0, short4 param1);
OVERLOADABLE short8 max (short8 param0, short8 param1);
OVERLOADABLE short16 max (short16 param0, short16 param1);
OVERLOADABLE int2 max (int2 param0, int2 param1);
OVERLOADABLE int3 max (int3 param0, int3 param1);
OVERLOADABLE int4 max (int4 param0, int4 param1);
OVERLOADABLE int8 max (int8 param0, int8 param1);
OVERLOADABLE int16 max (int16 param0, int16 param1);
OVERLOADABLE long2 max (long2 param0, long2 param1);
OVERLOADABLE long3 max (long3 param0, long3 param1);
OVERLOADABLE long4 max (long4 param0, long4 param1);
OVERLOADABLE long8 max (long8 param0, long8 param1);
OVERLOADABLE long16 max (long16 param0, long16 param1);
OVERLOADABLE uchar2 max (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 max (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 max (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 max (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 max (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 max (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 max (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 max (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 max (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 max (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 max (uint2 param0, uint2 param1);
OVERLOADABLE uint3 max (uint3 param0, uint3 param1);
OVERLOADABLE uint4 max (uint4 param0, uint4 param1);
OVERLOADABLE uint8 max (uint8 param0, uint8 param1);
OVERLOADABLE uint16 max (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 max (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 max (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 max (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 max (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 max (ulong16 param0, ulong16 param1);

//gentype max (gentype x,  sgentype y)

OVERLOADABLE char2 max (char2 param0, char param1);
OVERLOADABLE char3 max (char3 param0, char param1);
OVERLOADABLE char4 max (char4 param0, char param1);
OVERLOADABLE char8 max (char8 param0, char param1);
OVERLOADABLE char16 max (char16 param0, char param1);
OVERLOADABLE short2 max (short2 param0, short param1);
OVERLOADABLE short3 max (short3 param0, short param1);
OVERLOADABLE short4 max (short4 param0, short param1);
OVERLOADABLE short8 max (short8 param0, short param1);
OVERLOADABLE short16 max (short16 param0, short param1);
OVERLOADABLE int2 max (int2 param0, int param1);
OVERLOADABLE int3 max (int3 param0, int param1);
OVERLOADABLE int4 max (int4 param0, int param1);
OVERLOADABLE int8 max (int8 param0, int param1);
OVERLOADABLE int16 max (int16 param0, int param1);
OVERLOADABLE long2 max (long2 param0, long param1);
OVERLOADABLE long3 max (long3 param0, long param1);
OVERLOADABLE long4 max (long4 param0, long param1);
OVERLOADABLE long8 max (long8 param0, long param1);
OVERLOADABLE long16 max (long16 param0, long param1);
OVERLOADABLE uchar2 max (uchar2 param0, uchar param1);
OVERLOADABLE uchar3 max (uchar3 param0, uchar param1);
OVERLOADABLE uchar4 max (uchar4 param0, uchar param1);
OVERLOADABLE uchar8 max (uchar8 param0, uchar param1);
OVERLOADABLE uchar16 max (uchar16 param0, uchar param1);
OVERLOADABLE ushort2 max (ushort2 param0, ushort param1);
OVERLOADABLE ushort3 max (ushort3 param0, ushort param1);
OVERLOADABLE ushort4 max (ushort4 param0, ushort param1);
OVERLOADABLE ushort8 max (ushort8 param0, ushort param1);
OVERLOADABLE ushort16 max (ushort16 param0, ushort param1);
OVERLOADABLE uint2 max (uint2 param0, uint param1);
OVERLOADABLE uint3 max (uint3 param0, uint param1);
OVERLOADABLE uint4 max (uint4 param0, uint param1);
OVERLOADABLE uint8 max (uint8 param0, uint param1);
OVERLOADABLE uint16 max (uint16 param0, uint param1);
OVERLOADABLE ulong2 max (ulong2 param0, ulong param1);
OVERLOADABLE ulong3 max (ulong3 param0, ulong param1);
OVERLOADABLE ulong4 max (ulong4 param0, ulong param1);
OVERLOADABLE ulong8 max (ulong8 param0, ulong param1);
OVERLOADABLE ulong16 max (ulong16 param0, ulong param1);

//gentype min (gentype x,  gentype y)

OVERLOADABLE char2 min (char2 param0, char2 param1);
OVERLOADABLE char3 min (char3 param0, char3 param1);
OVERLOADABLE char4 min (char4 param0, char4 param1);
OVERLOADABLE char8 min (char8 param0, char8 param1);
OVERLOADABLE char16 min (char16 param0, char16 param1);
OVERLOADABLE short2 min (short2 param0, short2 param1);
OVERLOADABLE short3 min (short3 param0, short3 param1);
OVERLOADABLE short4 min (short4 param0, short4 param1);
OVERLOADABLE short8 min (short8 param0, short8 param1);
OVERLOADABLE short16 min (short16 param0, short16 param1);
OVERLOADABLE int2 min (int2 param0, int2 param1);
OVERLOADABLE int3 min (int3 param0, int3 param1);
OVERLOADABLE int4 min (int4 param0, int4 param1);
OVERLOADABLE int8 min (int8 param0, int8 param1);
OVERLOADABLE int16 min (int16 param0, int16 param1);
OVERLOADABLE long2 min (long2 param0, long2 param1);
OVERLOADABLE long3 min (long3 param0, long3 param1);
OVERLOADABLE long4 min (long4 param0, long4 param1);
OVERLOADABLE long8 min (long8 param0, long8 param1);
OVERLOADABLE long16 min (long16 param0, long16 param1);
OVERLOADABLE uchar2 min (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 min (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 min (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 min (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 min (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 min (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 min (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 min (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 min (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 min (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 min (uint2 param0, uint2 param1);
OVERLOADABLE uint3 min (uint3 param0, uint3 param1);
OVERLOADABLE uint4 min (uint4 param0, uint4 param1);
OVERLOADABLE uint8 min (uint8 param0, uint8 param1);
OVERLOADABLE uint16 min (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 min (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 min (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 min (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 min (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 min (ulong16 param0, ulong16 param1);

//gentype min (gentype x,  sgentype y)

OVERLOADABLE char2 min (char2 param0, char param1);
OVERLOADABLE char3 min (char3 param0, char param1);
OVERLOADABLE char4 min (char4 param0, char param1);
OVERLOADABLE char8 min (char8 param0, char param1);
OVERLOADABLE char16 min (char16 param0, char param1);
OVERLOADABLE short2 min (short2 param0, short param1);
OVERLOADABLE short3 min (short3 param0, short param1);
OVERLOADABLE short4 min (short4 param0, short param1);
OVERLOADABLE short8 min (short8 param0, short param1);
OVERLOADABLE short16 min (short16 param0, short param1);
OVERLOADABLE int2 min (int2 param0, int param1);
OVERLOADABLE int3 min (int3 param0, int param1);
OVERLOADABLE int4 min (int4 param0, int param1);
OVERLOADABLE int8 min (int8 param0, int param1);
OVERLOADABLE int16 min (int16 param0, int param1);
OVERLOADABLE long2 min (long2 param0, long param1);
OVERLOADABLE long3 min (long3 param0, long param1);
OVERLOADABLE long4 min (long4 param0, long param1);
OVERLOADABLE long8 min (long8 param0, long param1);
OVERLOADABLE long16 min (long16 param0, long param1);
OVERLOADABLE uchar2 min (uchar2 param0, uchar param1);
OVERLOADABLE uchar3 min (uchar3 param0, uchar param1);
OVERLOADABLE uchar4 min (uchar4 param0, uchar param1);
OVERLOADABLE uchar8 min (uchar8 param0, uchar param1);
OVERLOADABLE uchar16 min (uchar16 param0, uchar param1);
OVERLOADABLE ushort2 min (ushort2 param0, ushort param1);
OVERLOADABLE ushort3 min (ushort3 param0, ushort param1);
OVERLOADABLE ushort4 min (ushort4 param0, ushort param1);
OVERLOADABLE ushort8 min (ushort8 param0, ushort param1);
OVERLOADABLE ushort16 min (ushort16 param0, ushort param1);
OVERLOADABLE uint2 min (uint2 param0, uint param1);
OVERLOADABLE uint3 min (uint3 param0, uint param1);
OVERLOADABLE uint4 min (uint4 param0, uint param1);
OVERLOADABLE uint8 min (uint8 param0, uint param1);
OVERLOADABLE uint16 min (uint16 param0, uint param1);
OVERLOADABLE ulong2 min (ulong2 param0, ulong param1);
OVERLOADABLE ulong3 min (ulong3 param0, ulong param1);
OVERLOADABLE ulong4 min (ulong4 param0, ulong param1);
OVERLOADABLE ulong8 min (ulong8 param0, ulong param1);
OVERLOADABLE ulong16 min (ulong16 param0, ulong param1);

//gentype mul_hi (gentype x,  gentype y)

OVERLOADABLE char2 mul_hi (char2 param0, char2 param1);
OVERLOADABLE char3 mul_hi (char3 param0, char3 param1);
OVERLOADABLE char4 mul_hi (char4 param0, char4 param1);
OVERLOADABLE char8 mul_hi (char8 param0, char8 param1);
OVERLOADABLE char16 mul_hi (char16 param0, char16 param1);
OVERLOADABLE short2 mul_hi (short2 param0, short2 param1);
OVERLOADABLE short3 mul_hi (short3 param0, short3 param1);
OVERLOADABLE short4 mul_hi (short4 param0, short4 param1);
OVERLOADABLE short8 mul_hi (short8 param0, short8 param1);
OVERLOADABLE short16 mul_hi (short16 param0, short16 param1);
OVERLOADABLE int2 mul_hi (int2 param0, int2 param1);
OVERLOADABLE int3 mul_hi (int3 param0, int3 param1);
OVERLOADABLE int4 mul_hi (int4 param0, int4 param1);
OVERLOADABLE int8 mul_hi (int8 param0, int8 param1);
OVERLOADABLE int16 mul_hi (int16 param0, int16 param1);
OVERLOADABLE long2 mul_hi (long2 param0, long2 param1);
OVERLOADABLE long3 mul_hi (long3 param0, long3 param1);
OVERLOADABLE long4 mul_hi (long4 param0, long4 param1);
OVERLOADABLE long8 mul_hi (long8 param0, long8 param1);
OVERLOADABLE long16 mul_hi (long16 param0, long16 param1);
OVERLOADABLE uchar2 mul_hi (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 mul_hi (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 mul_hi (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 mul_hi (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 mul_hi (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 mul_hi (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 mul_hi (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 mul_hi (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 mul_hi (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 mul_hi (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 mul_hi (uint2 param0, uint2 param1);
OVERLOADABLE uint3 mul_hi (uint3 param0, uint3 param1);
OVERLOADABLE uint4 mul_hi (uint4 param0, uint4 param1);
OVERLOADABLE uint8 mul_hi (uint8 param0, uint8 param1);
OVERLOADABLE uint16 mul_hi (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 mul_hi (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 mul_hi (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 mul_hi (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 mul_hi (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 mul_hi (ulong16 param0, ulong16 param1);

//gentype rotate (gentype v,  gentype i)

OVERLOADABLE char2 rotate (char2 param0, char2 param1);
OVERLOADABLE char3 rotate (char3 param0, char3 param1);
OVERLOADABLE char4 rotate (char4 param0, char4 param1);
OVERLOADABLE char8 rotate (char8 param0, char8 param1);
OVERLOADABLE char16 rotate (char16 param0, char16 param1);
OVERLOADABLE short2 rotate (short2 param0, short2 param1);
OVERLOADABLE short3 rotate (short3 param0, short3 param1);
OVERLOADABLE short4 rotate (short4 param0, short4 param1);
OVERLOADABLE short8 rotate (short8 param0, short8 param1);
OVERLOADABLE short16 rotate (short16 param0, short16 param1);
OVERLOADABLE int2 rotate (int2 param0, int2 param1);
OVERLOADABLE int3 rotate (int3 param0, int3 param1);
OVERLOADABLE int4 rotate (int4 param0, int4 param1);
OVERLOADABLE int8 rotate (int8 param0, int8 param1);
OVERLOADABLE int16 rotate (int16 param0, int16 param1);
OVERLOADABLE long2 rotate (long2 param0, long2 param1);
OVERLOADABLE long3 rotate (long3 param0, long3 param1);
OVERLOADABLE long4 rotate (long4 param0, long4 param1);
OVERLOADABLE long8 rotate (long8 param0, long8 param1);
OVERLOADABLE long16 rotate (long16 param0, long16 param1);
OVERLOADABLE uchar2 rotate (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 rotate (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 rotate (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 rotate (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 rotate (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 rotate (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 rotate (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 rotate (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 rotate (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 rotate (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 rotate (uint2 param0, uint2 param1);
OVERLOADABLE uint3 rotate (uint3 param0, uint3 param1);
OVERLOADABLE uint4 rotate (uint4 param0, uint4 param1);
OVERLOADABLE uint8 rotate (uint8 param0, uint8 param1);
OVERLOADABLE uint16 rotate (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 rotate (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 rotate (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 rotate (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 rotate (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 rotate (ulong16 param0, ulong16 param1);

//gentype sub_sat (gentype x,  gentype y)

OVERLOADABLE char2 sub_sat (char2 param0, char2 param1);
OVERLOADABLE char3 sub_sat (char3 param0, char3 param1);
OVERLOADABLE char4 sub_sat (char4 param0, char4 param1);
OVERLOADABLE char8 sub_sat (char8 param0, char8 param1);
OVERLOADABLE char16 sub_sat (char16 param0, char16 param1);
OVERLOADABLE short2 sub_sat (short2 param0, short2 param1);
OVERLOADABLE short3 sub_sat (short3 param0, short3 param1);
OVERLOADABLE short4 sub_sat (short4 param0, short4 param1);
OVERLOADABLE short8 sub_sat (short8 param0, short8 param1);
OVERLOADABLE short16 sub_sat (short16 param0, short16 param1);
OVERLOADABLE int2 sub_sat (int2 param0, int2 param1);
OVERLOADABLE int3 sub_sat (int3 param0, int3 param1);
OVERLOADABLE int4 sub_sat (int4 param0, int4 param1);
OVERLOADABLE int8 sub_sat (int8 param0, int8 param1);
OVERLOADABLE int16 sub_sat (int16 param0, int16 param1);
OVERLOADABLE long2 sub_sat (long2 param0, long2 param1);
OVERLOADABLE long3 sub_sat (long3 param0, long3 param1);
OVERLOADABLE long4 sub_sat (long4 param0, long4 param1);
OVERLOADABLE long8 sub_sat (long8 param0, long8 param1);
OVERLOADABLE long16 sub_sat (long16 param0, long16 param1);
OVERLOADABLE uchar2 sub_sat (uchar2 param0, uchar2 param1);
OVERLOADABLE uchar3 sub_sat (uchar3 param0, uchar3 param1);
OVERLOADABLE uchar4 sub_sat (uchar4 param0, uchar4 param1);
OVERLOADABLE uchar8 sub_sat (uchar8 param0, uchar8 param1);
OVERLOADABLE uchar16 sub_sat (uchar16 param0, uchar16 param1);
OVERLOADABLE ushort2 sub_sat (ushort2 param0, ushort2 param1);
OVERLOADABLE ushort3 sub_sat (ushort3 param0, ushort3 param1);
OVERLOADABLE ushort4 sub_sat (ushort4 param0, ushort4 param1);
OVERLOADABLE ushort8 sub_sat (ushort8 param0, ushort8 param1);
OVERLOADABLE ushort16 sub_sat (ushort16 param0, ushort16 param1);
OVERLOADABLE uint2 sub_sat (uint2 param0, uint2 param1);
OVERLOADABLE uint3 sub_sat (uint3 param0, uint3 param1);
OVERLOADABLE uint4 sub_sat (uint4 param0, uint4 param1);
OVERLOADABLE uint8 sub_sat (uint8 param0, uint8 param1);
OVERLOADABLE uint16 sub_sat (uint16 param0, uint16 param1);
OVERLOADABLE ulong2 sub_sat (ulong2 param0, ulong2 param1);
OVERLOADABLE ulong3 sub_sat (ulong3 param0, ulong3 param1);
OVERLOADABLE ulong4 sub_sat (ulong4 param0, ulong4 param1);
OVERLOADABLE ulong8 sub_sat (ulong8 param0, ulong8 param1);
OVERLOADABLE ulong16 sub_sat (ulong16 param0, ulong16 param1);

//shortn upsample (charn hi, ucharn lo)

OVERLOADABLE short2 upsample (char2 param0, uchar2 param1);
OVERLOADABLE short3 upsample (char3 param0, uchar3 param1);
OVERLOADABLE short4 upsample (char4 param0, uchar4 param1);
OVERLOADABLE short8 upsample (char8 param0, uchar8 param1);
OVERLOADABLE short16 upsample (char16 param0, uchar16 param1);

//ushortn upsample (ucharn hi, ucharn lo)

OVERLOADABLE ushort2 upsample (uchar2 param0, uchar2 param1);
OVERLOADABLE ushort3 upsample (uchar3 param0, uchar3 param1);
OVERLOADABLE ushort4 upsample (uchar4 param0, uchar4 param1);
OVERLOADABLE ushort8 upsample (uchar8 param0, uchar8 param1);
OVERLOADABLE ushort16 upsample (uchar16 param0, uchar16 param1);

//intn upsample (shortn hi, ushortn lo)

OVERLOADABLE int2 upsample (short2 param0, ushort2 param1);
OVERLOADABLE int3 upsample (short3 param0, ushort3 param1);
OVERLOADABLE int4 upsample (short4 param0, ushort4 param1);
OVERLOADABLE int8 upsample (short8 param0, ushort8 param1);
OVERLOADABLE int16 upsample (short16 param0, ushort16 param1);

//uintn upsample (ushortn hi, ushortn lo)

OVERLOADABLE uint2 upsample (ushort2 param0, ushort2 param1);
OVERLOADABLE uint3 upsample (ushort3 param0, ushort3 param1);
OVERLOADABLE uint4 upsample (ushort4 param0, ushort4 param1);
OVERLOADABLE uint8 upsample (ushort8 param0, ushort8 param1);
OVERLOADABLE uint16 upsample (ushort16 param0, ushort16 param1);

//longn upsample (intn hi, uintn lo)

OVERLOADABLE long2 upsample (int2 param0, uint2 param1);
OVERLOADABLE long3 upsample (int3 param0, uint3 param1);
OVERLOADABLE long4 upsample (int4 param0, uint4 param1);
OVERLOADABLE long8 upsample (int8 param0, uint8 param1);
OVERLOADABLE long16 upsample (int16 param0, uint16 param1);

//ulongn upsample (uintn hi, uintn lo)

OVERLOADABLE ulong2 upsample (uint2 param0, uint2 param1);
OVERLOADABLE ulong3 upsample (uint3 param0, uint3 param1);
OVERLOADABLE ulong4 upsample (uint4 param0, uint4 param1);
OVERLOADABLE ulong8 upsample (uint8 param0, uint8 param1);
OVERLOADABLE ulong16 upsample (uint16 param0, uint16 param1);

//gentype popcount (gentype x)

OVERLOADABLE char2 popcount (char2 param0);
OVERLOADABLE char3 popcount (char3 param0);
OVERLOADABLE char4 popcount (char4 param0);
OVERLOADABLE char8 popcount (char8 param0);
OVERLOADABLE char16 popcount (char16 param0);
OVERLOADABLE short2 popcount (short2 param0);
OVERLOADABLE short3 popcount (short3 param0);
OVERLOADABLE short4 popcount (short4 param0);
OVERLOADABLE short8 popcount (short8 param0);
OVERLOADABLE short16 popcount (short16 param0);
OVERLOADABLE int2 popcount (int2 param0);
OVERLOADABLE int3 popcount (int3 param0);
OVERLOADABLE int4 popcount (int4 param0);
OVERLOADABLE int8 popcount (int8 param0);
OVERLOADABLE int16 popcount (int16 param0);
OVERLOADABLE long2 popcount (long2 param0);
OVERLOADABLE long3 popcount (long3 param0);
OVERLOADABLE long4 popcount (long4 param0);
OVERLOADABLE long8 popcount (long8 param0);
OVERLOADABLE long16 popcount (long16 param0);
OVERLOADABLE uchar2 popcount (uchar2 param0);
OVERLOADABLE uchar3 popcount (uchar3 param0);
OVERLOADABLE uchar4 popcount (uchar4 param0);
OVERLOADABLE uchar8 popcount (uchar8 param0);
OVERLOADABLE uchar16 popcount (uchar16 param0);
OVERLOADABLE ushort2 popcount (ushort2 param0);
OVERLOADABLE ushort3 popcount (ushort3 param0);
OVERLOADABLE ushort4 popcount (ushort4 param0);
OVERLOADABLE ushort8 popcount (ushort8 param0);
OVERLOADABLE ushort16 popcount (ushort16 param0);
OVERLOADABLE uint2 popcount (uint2 param0);
OVERLOADABLE uint3 popcount (uint3 param0);
OVERLOADABLE uint4 popcount (uint4 param0);
OVERLOADABLE uint8 popcount (uint8 param0);
OVERLOADABLE uint16 popcount (uint16 param0);
OVERLOADABLE ulong2 popcount (ulong2 param0);
OVERLOADABLE ulong3 popcount (ulong3 param0);
OVERLOADABLE ulong4 popcount (ulong4 param0);
OVERLOADABLE ulong8 popcount (ulong8 param0);
OVERLOADABLE ulong16 popcount (ulong16 param0);

//fast_integer builtin functions
//gentype mad24 (gentype x, gentype y, gentype z)

OVERLOADABLE uint2 mad24 (uint2 param0, uint2 param1, uint2 param2);
OVERLOADABLE uint3 mad24 (uint3 param0, uint3 param1, uint3 param2);
OVERLOADABLE uint4 mad24 (uint4 param0, uint4 param1, uint4 param2);
OVERLOADABLE uint8 mad24 (uint8 param0, uint8 param1, uint8 param2);
OVERLOADABLE uint16 mad24 (uint16 param0, uint16 param1, uint16 param2);
OVERLOADABLE int2 mad24 (int2 param0, int2 param1, int2 param2);
OVERLOADABLE int3 mad24 (int3 param0, int3 param1, int3 param2);
OVERLOADABLE int4 mad24 (int4 param0, int4 param1, int4 param2);
OVERLOADABLE int8 mad24 (int8 param0, int8 param1, int8 param2);
OVERLOADABLE int16 mad24 (int16 param0, int16 param1, int16 param2);

//gentype mul24 (gentype x, gentype y)

OVERLOADABLE uint2 mul24 (uint2 param0, uint2 param1);
OVERLOADABLE uint3 mul24 (uint3 param0, uint3 param1);
OVERLOADABLE uint4 mul24 (uint4 param0, uint4 param1);
OVERLOADABLE uint8 mul24 (uint8 param0, uint8 param1);
OVERLOADABLE uint16 mul24 (uint16 param0, uint16 param1);
OVERLOADABLE int2 mul24 (int2 param0, int2 param1);
OVERLOADABLE int3 mul24 (int3 param0, int3 param1);
OVERLOADABLE int4 mul24 (int4 param0, int4 param1);
OVERLOADABLE int8 mul24 (int8 param0, int8 param1);
OVERLOADABLE int16 mul24 (int16 param0, int16 param1);

#endif
