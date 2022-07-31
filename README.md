## Neovim

### Neovim Keys

#### Align text

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `<sp>xa1` | Align to an entered character |
| Normal | `<sp>xa2` | Align to an entered couplet |
| Normal | `<sp>xa=` | Align `=`s |
| Normal | `<sp>xa:` | Align `::`s |
| Normal | `<sp>xa,` | Align `,`s |
| Normal | `<sp>xa\|` | Align `\|`s |
| Normal | `<sp>xap` | Prompt for a lua pattern and align based on that |
| Normal | `<sp>xas` | Prompt for string and align based on that |

#### Buffer navigation

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `<sp>1` through `<sp>9` | Select an open buffer visible in the buffer line, by ordinal. |
| Normal | `<sp>b.` | Select a buffer by typing the letter shown next to each open buffer in the buffer bar. |
| Normal | `<sp>bp` | Previous buffer |
| Normal | `<sp>bn` | Next buffer |
| Normal | `<sp>bd` | Delete buffer but leave window in place |
| Normal | `<sp>bD` | Scorched earth policy. Delete all buffers |

#### Completion

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `<tab>` | Next suggested completion. |
| Normal | `<s-tab>` | Previous suggested completion. |
| Normal | `<c-b>` | Scroll up in the documentation popup. |
| Normal | `<c-f>` | Scroll down in the documentation popup. |
| Normal | `<c-y>` | Take the currently selected completion, or the first one if none is selected. |
| Normal | `<c-e>` | Stop suggesting. |

#### Diagnostics (Compiler errors and similar)

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `<sp>dl` | Pop up a window showing all diagnostics applying to the current line |
| Normal | `<sp>db` | Pop up a window showing all diagnostics applying to the current buffer |
| Normal | `<sp>dt` | Toggle expanded multiline diagnostics |
| Normal | `<sp>dw` | Pop up a window showing all diagnostics applying to the current workspace |
| Normal | `[d` | Jump to previous diagnostic site |
| Normal | `]d` | Jump to next diagnostic site |

#### Telescope (fuzzy find)

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `<sp>.` | Show files in project and variously open the selected files. |
| Normal | `<sp>r` | Resume the last find. |
| Normal | `<sp>f.` | Show files in project and open the first selected file and put all selected files in quickfix. |
| Normal | `<sp>fr` | Show recently opened files. |
| Normal | `<sp>ss` | Fuzzy find within lines of the current buffer. `<cr>` to go to the selected line. |
| Normal | `<sp>st` | Fuzzy find symbols in the current file queried from treesitter. |
| Normal | `<sp>?` | Prompt for glob (e.g. `*.hs`) and filetype (e.g. `hs`) and pattern, then vimgrep and fuzzy find on the results and open selection(s).  |
| Normal | `<sp>/` | Prompt query for ripgrep, then fuzzy find on the results and open selection(s). See FZF files result keys below. |
| Normal | `<sp>bb` | Fuzzy find among open buffers by name. `<cr>` to switch to selection. |
| Normal | `<sp>hs` | Fuzzy find among editor help files. `<cr>` to go to selection. |

#### Git

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `[c` | Jump to previous change site. |
| Normal | `]c` | Jump to next change site. |
| Normal | `<sp>gbb` | Git blame the current file. But also see `<sp>gbt`. |
| Normal | `<sp>gbd` | Diff the current buffer ala `git diff`. |
| Normal | `<sp>gbl` | Pop up a window showing information about the last commit that affected this line. |
| Normal | `<sp>gbt` | Toggle on/off showing blame information at the end of the current line's text. |
| Normal | `<sp>gbr` | Reset (unstage) the buffer. |
| Normal | `<sp>gbs` | Stage the whole buffer. |
| Normal | `<sp>gdt` | Toggle showing deleted lines. |
| Normal | `<sp>ghd` | Vimdiff the current file against the index. |
| Normal | `<sp>ghD` | Vimdiff the current file against HEAD. |
| Normal or Visual | `<sp>ghs` | Stage the current / marked hunk. |
| Normal or Visual | `<sp>ghr` | Reset (unstage) the current / marked hunk. |
| Normal | `<sp>ghu` | Unstage the last hunk staged. |
| Normal | `<sp>ghp` | Show the current hunk in diff form. |
| Normal | `<sp>gld` | Git log the repository. |
| Normal | `<sp>glb` | Git log the current buffer. |
| Normal | `<sp>gs` | Show git status. Also where you select things to stage and commit. `g?` for help on keys in the status buffer. |
| Text object | `ih` | Inside current hunk. |

#### LSP (Language Server)

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `gD` | Jumps to the declaration of the symbol under cursor. Not in Haskell though. |
| Normal | `gd` | Jumps to the definition of the symbol under cursor. Only local definitions in Haskell though. |
| Normal | `gi` | Jumps to the implementation of the symbol under cursor. |
| Normal | `gr` | Jump to a reference to the symbol under cursor. |
| Normal | `K` | Shows a pop up with information about the symbol under cursor. Do it again to focus in the pop up. `q` to leave focus. |
| Normal | `<c-k>` | Shows pop up with signature information about the symbol under cursor. Not in Haskell though. |
| Normal | `<sp>ca` | Show code actions that apply to the code under the cursor. |
| Normal | `<sp>f` | Format the buffer. Via whatever is configured in HLS for Haskell. rustfmt for rust. |
| Normal (Haskell) | `<sp>hf` | Fill the current hole by the "auto" tactic, which just tries a few things until something fits. |
| Normal (Haskell) | `<sp>hr` | Refine the current hole. |
| Normal (Haskell) | `<sp>hc1` | Case split on the function parameter, generating additional equations for each constructor. Only works if there's one. Try `<sp>ca` if there's more than one. |
| Normal (Haskell) | `<sp>hcp` | Case split on the function parameter, generating additional equations for each constructor. Use NamedFieldPuns. |
| Normal (Haskell) | `<sp>hca` | Case split on all function parameters (cross product), generating additional equations for each constructor. Use NamedFieldPuns. |
| Normal (Haskell) | `<sp>hid` | Fill a function hole with a lambda and case or additional function equations, one case arm or equation per constructor. |
| Normal (Haskell) | `<sp>hil` | Fill a function hole with a lambda or additional function equations. |
| Normal | `<sp>sr` | Rename symbol. |
| Normal | `<sp>sf` | Query symbols in the whole workspace. |
| Normal | `<sp>sl` | Fuzzy find among the symbols in the current buffer. |
| Normal | `<sp>wa` | Add another folder to the workspace. |
| Normal | `<sp>wr` | Remove a folder from the workspace. |
| Normal | `<sp>wl` | Show the folders open in the workspace. |

#### Misc.

| Mode | Key | Effect |
| --- | --- | --- |
| Normal | `Q` | Run the `q` macro. I.e. `qq...q` to record, `Q` to play. Equivalent to `@q`. |
| Normal | `<up>` | Show quickfix. |
| Normal | `<down>` | Hide quickfix. |
| Normal | `<left>` | Jump to the previous thing in quickfix. |
| Normal | `<right>` | Jump to the next thing in quickfix. |
| Normal | `<cr>` | Jump to the current thing in quickfix. |
| Normal | `<c-j>` | Insert a linebreak and return to Normal. |
| All-ish | `<f10>` | Show the current highlighting information, for debugging syntaxes. Not useful with treesitter though. |
| Normal, Visual, Opr. | `<sp>sc` | Clear search highlights. |
| Normal | `<sp>e` | `:e` but with the path to the current file prepopulated, for editing files nearby the current one. |
| Normal | `<sp><tab>` | Switch to the previously active buffer. |

