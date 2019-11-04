local iron = require('iron')

iron.core.add_repl_definitions{
  ruby = {
    pry = {
      command = {"pry"}
    }
  },
  elixir = {
    mix = {
      command = {"iex", "-S", "mix"}
    }
  }
}

iron.core.set_config {
  preferred = {
    python = "ipython",
    clojure = "lein",
    ruby = "pry",
    elixir = "mix"
  }
}

local colorizer = require('colorizer')
colorizer.setup()
