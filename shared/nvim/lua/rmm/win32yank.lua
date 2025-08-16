local win32yankpath = vim.fn.getenv("HOME") .. "/.local/bin/win32yank.exe"
if vim.fn.executable(win32yankpath) == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["*"] = win32yankpath .. " -i --crlf",
      ["+"] = win32yankpath .. " -i --crlf",
    },
    paste = {
      ["*"] = win32yankpath .. " -o --lf",
      ["+"] = win32yankpath .. " -o --lf",
    },
    cache_enabled = false
  }
end
