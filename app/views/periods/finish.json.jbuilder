json.id @period._id
json.(@period, :description, :started_at, :finished_at)
json.(@period.subcategory, :background, :white_text)
json.category_name @period.subcategory.name
