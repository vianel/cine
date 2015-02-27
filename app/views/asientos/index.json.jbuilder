json.array!(@asientos) do |asiento|
  json.extract! asiento, :id, :posicion, :sala
  json.url asiento_url(asiento, format: :json)
end
