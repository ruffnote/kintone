require 'kintone/command'

class Kintone::Command::App < Kintone::Command
  def self.path
    'app'
  end

  def get(id)
    @api.get(@url, id: id)
  end

  def register(name)
    url = '/k/v1/preview/app.json'
    res = @api.post(url, name:name)
    app = res['app'].to_i
    deploy(app)
  end

  def deploy(app)
    url = '/k/v1/preview/app/deploy.json'
    @api.post(url, apps:[{app: app}])
  end
end
