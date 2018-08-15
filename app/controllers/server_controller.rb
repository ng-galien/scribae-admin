class ServerController < ApplicationController

    def update
      `rm tmp/restart.txt`
    end
end