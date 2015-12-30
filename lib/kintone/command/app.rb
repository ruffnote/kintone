require 'kintone/command'

class Kintone::Command::App < Kintone::Command
  def self.path
    'app'
  end

  def get(id)
    @api.get(@url, id: id)
  end

  def register(name, fields=nil)
    url = '/k/v1/preview/app.json'
    res = @api.post(url, name:name)
    app = res['app'].to_i
    register_fields(app, fields) if fields
    deploy(app)
    return {app: app, name: name}
  end

  def register_fields(app, fields)
    url = '/k/v1/preview/app/form/fields.json'
    params = {app: app, properties: fields}
    @api.post(url, params)
  end

  def deploy(app)
    url = '/k/v1/preview/app/deploy.json'
    @api.post(url, apps:[{app: app}])
  end
end
