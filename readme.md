## API

### Restaraunt menu

`GET /api/restarauntData`

response:

```JSON
{
  "categoriesById": {
    "int <categoryId>": {
      "id": "int <categoryId>",
      "name": "string",
      "top_level": "int <0|1>",
      "multiselect": "int <0|1>",
      "items": ["int <productId>"]
    }
  },
  "productsById": {
    "int <productId>": {
      "id": "int <productId>",
      "menu_category_id": "int <categoryId>",
      "name": "string",
      "price": "float",
      "modifiers": ["int <categoryId>"]
    }
  },
  "categories": ["int <categoryId>"]
}
```

### Basket

`POST /api/basket` - Add item to basket

payload:

```json
{
  "qty": "int",
  "itemId": "int <productId>",
  "modifiers": {
    "int <productId>": "int <qty>"
  }
}
```

response:

```json
[
  {
    "id": "int",
    "menu_item_id": "int <productId>",
    "qty": "int",
    "modifiers": [
      {
        "id": "int",
        "basket_item_id": "int <baskedItemId>",
        "menu_item_id": "int <productId>",
        "qty": "int"
      }
    ]
  }
]
```

`GET /api/basket` - Get items in basket

response:

```json
[
  {
    "id": "int <baskedItemId>",
    "menu_item_id": "int <productId>",
    "qty": "int",
    "modifiers": [
      {
        "id": "int",
        "basket_item_id": "int <baskedItemId>",
        "menu_item_id": "int <productId>",
        "qty": "int"
      }
    ]
  }
]
```
