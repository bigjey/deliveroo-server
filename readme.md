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
      "top_level": "int <bool>",
      "multiselect": "int <bool>",
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

#### Add item to basket

`POST /api/basket`

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

#### Get items in basket

`GET /api/basket`

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
