express = require 'express'
app = express()

app.use express.favicon()
app.use express.static "#{__dirname}"

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  res.render 'index'

port = process.env.PORT || 3000
app.listen port, ->
  console.log "http://localhost:#{port}"
