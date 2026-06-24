local function heredoc(lines)
  return "cat << 'SNACKS_EOF'\n" .. table.concat(lines, "\n") .. "\nSNACKS_EOF"
end

local function git_lines()
  local in_git = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match"true"
  if not in_git then return { "  Not in a git repository" } end
  local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+", "")
  local changes = vim.fn.system("git status --short 2>/dev/null | wc -l"):gsub("%s+", "")
  local lines = { "  Branch: " .. branch, "  Changes: " .. changes .. " files", "" }
  local log = vim.fn.system("git log --graph --oneline --decorate -6 2>/dev/null")
  for _, line in ipairs(vim.split(log, "\n", { plain = true })) do
    if line ~= "" then table.insert(lines, "  " .. line) end
  end
  table.insert(lines, "")
  table.insert(lines, "  <leader>gg = LazyGit")
  return lines
end

local function sys_lines()
  local os = vim.fn.system("uname -o 2>/dev/null"):gsub(".*/", ""):gsub("%s+", "")
  local kernel = vim.fn.system("uname -r 2>/dev/null"):gsub("%s+", "")
  local uptime = vim.fn.system("uptime -p 2>/dev/null"):gsub("^up ", ""):gsub("%s+", " ")
  local ram = vim.fn.system("free -h 2>/dev/null | awk '/^Mem:/ {print $3\"/\"$2}'"):gsub("%s+", "")
  local nvim = vim.fn.system("nvim --version 2>/dev/null | head -1 | cut -d' ' -f2"):gsub("%s+", "")
  return {
    "  " .. os .. "  |  Kernel: " .. kernel,
    "  " .. uptime .. "  |  RAM: " .. ram,
    "  Neovim " .. nvim,
    "",
    "  <F1> = Cheatsheet  |  <leader>ff = Suche",
  }
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        {
          pane = 1, section = "terminal",
          cmd = heredoc(git_lines()),
          height = 12, padding = 1, title = "Git",
        },
        {
          pane = 2, section = "terminal",
          cmd = heredoc(sys_lines()),
          height = 12, padding = 1, title = "System",
        },
        { section = "startup" },
        { section = "recent_files", title = "Letzte Dateien", indent = 2, padding = 1 },
        { section = "projects", title = "Projekte", indent = 2, padding = 1 },
      },
      header = [[
   ______           __             ____  _____
  / ____/___ ______/ /_  __  __   / __ \/ ___/
 / /   / __ `/ ___/ __ \/ / / /  / / / /\__ \ 
/ /___/ /_/ / /__/ / / / /_/ /  / /_/ ___/ / 
\____/\__,_/\___/_/ /_/\__, /   \____//____/  
                      /____/                   ]],
    },
    notifier = { enabled = true, timeout = 3000 },
    indent = { enabled = true, char = "│" },
    input = { enabled = true },
  },
  keys = {
    { "<leader>.", function() Snacks.scratch() end, desc = "Notizzettel" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Benachrichtigungen" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Buffer schliessen" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit öffnen" },
  },
}
