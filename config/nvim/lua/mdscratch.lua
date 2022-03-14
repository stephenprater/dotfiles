local M = {}

-- select all text between two h1 headers in a markdown file
function M.select_between_headers()
  print("okay")

  -- search between all six headers lengths
  -- take the shortest one
  -- assign that to the visual range
  -- voila text object

  -- search backward for the first number 1 header
  local first_line = vim.fn.searchpos("^#\\s", "b")[1]

  local possible_ranges = {}
  for i = 1, 6 do
    regex = string.format("^#\\{%d}\\s.\\{-}$", i)
    print(regex)
    local start_line = vim.fn.searchpos(regex,'b',first_line)[1]
    local end_line = vim.fn.searchpos(regex,'',vim.fn.line('$'))[1]
    -- store the start and end line the possible range table
    possible_ranges[i] = {start_line, end_line}
  end

  print(vim.inspect(possible_ranges))

  -- find the shortest range
  -- local shortest_range = possible_ranges[1]

  -- vim.fn.setpos("'<",{0,start_line[1],1,0})
  -- vim.fn.setpos("'>",{0,end_line[1]-1,1,0})
  -- vim.cmd [[normal! `<V`>]]
end

return M
