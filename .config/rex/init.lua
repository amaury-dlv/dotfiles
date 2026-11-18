local terminal = "com.superlogical.terminal"
local shell = "com.superlogical.terminal.shell"

-- The focused terminal's directory: what its shell last reported, or else
-- the working directory of the program running in it.
local function focused_cwd(ctx)
  if ctx.block_id == nil then return nil end
  local pwd = rex.block.call(terminal, "pwd", { block_id = ctx.block_id })
  if pwd and pwd.pwd and pwd.pwd ~= "" then return pwd.pwd end
  local proc = rex.block.call(terminal, "process", { block_id = ctx.block_id })
  return proc and proc.foreground and proc.foreground.cwd
end

local function claude_block(ctx)
  return rex.layout.block{
    flavor = shell,
    label = "claude",
    options = {
      -- An interactive zsh reads .zshrc, so claude gets its PATH and alias.
      command = { "zsh", "-ic", "claude" },
      shell = "none",
      cwd = focused_cwd(ctx),
    },
  }
end

rex.action{
  name = "claude_tab",
  title = "New Claude Tab",
  category = "Claude",
  run = function(ctx, args)
    local w, err = rex.session.new_window{ layout = claude_block(ctx) }
    if err ~= nil then error(err, 0) end
    return { window_id = w.window_id }
  end,
}

-- Split like cmd+enter (best fit): side by side if the focused pane is at
-- least as wide as it is tall in pixels, otherwise one above the other.
rex.action{
  name = "claude_pane",
  title = "New Claude Pane",
  category = "Claude",
  run = function(ctx, args)
    local direction = "horizontal"
    if ctx.block_id ~= nil then
      local s = rex.block.call(terminal, "size", { block_id = ctx.block_id })
      if s and s.columns and s.cell_width_px
          and s.columns * s.cell_width_px < s.rows * s.cell_height_px then
        direction = "vertical"
      end
    end
    local r, err = rex.session.new_split{
      anchor_id = ctx.block_id,
      direction = direction,
      side = "after",
      focus = true,
      layout = claude_block(ctx),
    }
    if err ~= nil then error(err, 0) end
    return { block_ids = r.block_ids }
  end,
}

rex.bind("ctrl+shift+t", "claude_tab")
rex.bind("ctrl+cmd+enter", "claude_pane")
