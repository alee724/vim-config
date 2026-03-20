local projectfile = vim.fn.getcwd() .. '/project.godot'
if projectfile then
    vim.fn.serverstart '/tmp/godothost'
end
vim.g.godot_executable = '/Applications/Godot.app/Contents/MacOS/Godot'

