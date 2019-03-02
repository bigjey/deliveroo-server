## API

### Restaraunt menu

```JSON
GET /api/restarauntData

{
  "categoriesById": {
    "1": {
      "id": Number,
      "name": String,
      "top_level": Number,
      "multiselect": Number,
      "items": [Number]
    }
  },
  "productsById": {
    "id": Number,
    "menu_category_id": Number,
    "name": String,
    "price": Number,
    "modifiers": [Number]
  },
  "categories": [Number]
}
```
