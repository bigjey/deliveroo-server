## API

### Restaraunt menu

```JSON
GET /api/restarauntData

{
  "categoriesById": {
    "1": {
      "id": int,
      "name": string,
      "top_level": int,
      "multiselect": int,
      "items": [int]
    }
  },
  "productsById": {
    "id": int,
    "menu_category_id": int,
    "name": string,
    "price": float,
    "modifiers": [int]
  },
  "categories": [int]
}
```