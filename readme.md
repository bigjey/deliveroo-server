## API

### Restaraunt menu

`GET /api/restarauntData`

response:

```JSON
{
  "categoriesById": {
    "1": {
      "id": "int",
      "name": "string",
      "top_level": "int",
      "multiselect": "int",
      "items": ["int"]
    }
  },
  "productsById": {
    "1": {
      "id": "int",
      "menu_category_id": "int",
      "name": "string",
      "price": "float",
      "modifiers": ["int"]
    }
  },
  "categories": ["int"]
}
```

| Field                       | Description           |
| --------------------------- | --------------------- |
| `categoriesById.[].items`   | list of `product id`  |
| `productsById.[].modifiers` | list of `category id` |
