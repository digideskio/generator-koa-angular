# TODO: apiCtrl      = require "./api_ctrl.js"
bodyParser   = require "koa-bodyparser"
bunyan       = require "koa-bunyan"
json         = require "koa-json"
koa          = require "koa"
livereload   = require "koa-livereload"
logger       = require "./logger.js"
parse        = require "co-body"
route        = require "koa-route"
serve        = require "koa-static"
session      = require "koa-session"
views        = require "co-views"

app = module.exports = koa()

app.use bunyan(logger,
    level: "info"
    timeLimit: 250
  )
app.use json()
app.use session()
app.use livereload()
app.use bodyParser()
render = views "views/"
app.use serve "public/"
require("koa-qs")(app)

app.use route.get "/", ->
  @body = yield render "index.jade"

app.listen 3000
