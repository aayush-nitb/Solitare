getURL = undefined

testPage = (req, res) ->
  res.render 'main/views/test',
    title: 'WebExpress'
    url: getURL.bind(base: 'main')
  return

exports.configure = (app, fileProvider) ->
    getURL = fileProvider
    app.get '/test', testPage