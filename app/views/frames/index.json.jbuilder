json.array!(@frames) do |frame|
  json.extract! frame, :id, :name, :brand_id
  json.url frame_url(frame, format: :json)
end
