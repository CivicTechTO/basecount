json.extract! site, 
  :id,
  :name,
  :address1,
  :address2,
  :city,
  :postal_code,
  :description,
  :lat,
  :lng,
  :org_id,
  :created_at,
  :updated_at
json.url site_url(site, format: :json)
