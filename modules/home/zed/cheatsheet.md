# Zed cheatsheet

`F1` bu dosyayı açar. `ctrl-shift-v` ile önizleme. Komut paleti: `:` veya `space ?`.
Okların yanında hjkl da çalışır.

## Paneller

| tuş | iş |
|---|---|
| `alt-s` | dosya paneli (tekrar / `esc` kapatır) |
| `alt-space` | terminal |
| `ctrl-space` | git paneli |
| `space e` | dosya paneline odaklan |
| `space g` | debug paneli |

Dosya panelinde: `←` `→` kapat/aç, `enter` aç, `%` yeni dosya, `d` yeni dizin,
`shift-r` yeniden adlandır, `shift-d` sil, `/` dizinde ara.

## Hareket

| tuş | iş |
|---|---|
| `← ↓ ↑ →` | karakter / satır |
| `w` `b` `e` | sonraki kelime / önceki kelime / kelime sonu |
| `g ←` `g →` | satır başı / satır sonu |
| `g s` | satırdaki ilk karakter |
| `g g` `g e` | dosya başı / dosya sonu |
| `shift-g` | satıra git |
| `ctrl-u` `ctrl-d` | yarım sayfa yukarı / aşağı |
| `ctrl-o` `ctrl-i` | geri / ileri (jumplist) |
| `f` `t` + harf | harfe / harften önceye git |
| `g w` | kelimeye atla (etiketli) |
| `g .` | son değişikliğe git |

## Seçim ve düzenleme

| tuş | iş |
|---|---|
| `x` / `shift-x` | satırı seç / genişlet |
| `%` | tümünü seç |
| `s` | seçim içinde regex → çoklu imleç |
| `alt-s` | seçimi satırlara böl |
| `shift-c` | imleci alt satıra kopyala |
| `;` / `alt-;` | seçimi daralt / diğer uca geç |
| `,` | sadece son seçimi tut |
| `alt-o` / `alt-i` | syntax node büyüt / küçült |
| `m m` | eşleşen paranteze git |
| `m s` / `m r` / `m d` + karakter | surround ekle / değiştir / sil |
| `m i` / `m a` + nesne | içini / tamamını seç (`m i w`, `m a (`) |
| `d` / `c` / `y` / `p` | sil / değiştir / kopyala / yapıştır |
| `alt-↑` `alt-↓` | satırı yukarı / aşağı taşı |
| `ctrl-c` | yorum aç/kapat |
| `u` / `shift-u` | geri al / yinele |
| `shift-q` / `q` | makro kaydet / oynat |

## Sekmeler ve pencereler

| tuş | iş |
|---|---|
| `alt-←` `alt-→` | önceki / sonraki sekme |
| `ctrl-tab` | sonraki sekme |
| `space b` | sekme seçici |
| `space j` | önceki dosyaya dön |
| `space q` / `space shift-q` | sekmeyi kapat / pencereyi kapat |
| `space w v` / `space w s` | sağa böl / aşağı böl |
| `space w ← ↓ ↑ →` | pane'e geç |
| `space w shift-←…` | pane'i o yöne taşı |
| `space u z` | pane'i büyüt (zoom) |

## Bulma

| tuş | iş |
|---|---|
| `space f` | dosya bul |
| `space shift-f` | son projeler |
| `space /` | projede ara |
| `/` | dosyada ara, `n` / `shift-n` sonraki / önceki |
| `*` | seçimi arama yap |
| `space s` / `space shift-s` | sembol (dosya) / sembol (proje) |

## LSP

| tuş | iş |
|---|---|
| `g d` / `g y` / `g i` | tanım / tip tanımı / implementasyon |
| `g r` veya `space h` | referanslar |
| `space k` | hover |
| `space a` | code action |
| `space r` | yeniden adlandır |
| `space d` / `space shift-d` | sonraki diagnostic / hepsi |
| `space l f` / `l r` / `l l` | formatla / LSP restart / LSP log |

## Aç / kapa (`space u`)

| tuş | iş |
|---|---|
| `space u w` | soft wrap |
| `space u i` | inlay hint |
| `space u d` | inline diagnostic |
| `space u m` | minimap |
| `space u z` | zoom |

## jj (`space v`)

Git paneli ve gutter jj'nin working copy'sini (`@`) doğru gösterir.
Panelin **stage / commit butonlarını kullanma**, kayıt işleri aşağıdan.

| tuş | iş |
|---|---|
| `space v v` | jjui |
| `space v shift-v` | lazyjj |
| `space v g` | lazygit |
| `space v s` | git paneli |
| `space v d` | tüm değişikliklerin diff'i (Zed görünümü) |
| `space v n` / `space v p` | sonraki / önceki hunk |
| `space v r` | hunk'ı geri al |
| `space v e` | `jj describe` |
| `space v c` | `jj new` (describe + new = commit) |
| `space v l` | `jj log` |
| `space v f` | `jj git fetch` |
| `space v u` | `jj undo` |
| `space v m` | bookmark listesi |

Açık dosya için:

| tuş | iş |
|---|---|
| `space v shift-d` | `jj diff` (bu dosya) |
| `space v shift-l` | `jj log` (bu dosya) |
| `space v b` | `jj file annotate` (blame) |
| `space v shift-r` | `jj restore`: dosyadaki değişiklikleri at |
| `space v shift-s` | `jj squash`: dosyayı parent'a taşı |

Yanlış bir şey yaparsan: `space v u`.
