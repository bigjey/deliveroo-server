const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const bodyParser = require("body-parser");
const fs = require("fs");

const sql_data = fs.readFileSync("./sql_data.sql", "utf-8");

const app = express();

const PORT = process.env.PORT || 3123;

const connection = mysql.createConnection({
  host: "localhost",
  user: "admin",
  password: "admin",
  database: "deliveroo",
  multipleStatements: true
});

const q = (query, values = []) => {
  return new Promise((resolve, reject) => {
    connection.query(query, values, (error, results, fields) => {
      if (error) {
        reject(error);
      } else {
        resolve({ results, fields });
      }
    });
  });
};

connection.connect();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/api/basket/items", async (req, res) => {
  try {
    const { results: rows } = await q("SELECT * FROM `basket_item`;");

    res.json(rows);
  } catch (e) {
    console.log(e);
    res.status(400).end();
  }
});

app.get("/api/basket/modifiers", async (req, res) => {
  try {
    const { results: rows } = await q("SELECT * FROM `basket_item_modifier`;");

    res.json(rows);
  } catch (e) {
    console.log(e);
    res.status(400).end();
  }
});

app.post("/api/basket/items", async (req, res) => {
  try {
    const { qty, itemId, modifiers } = req.body;

    if (typeof qty === "undefined" || isNaN(qty) || Number(qty) < 1) {
      throw new Error("qty param is not correct");
    }

    if (typeof itemId === "undefined" || isNaN(itemId) || Number(itemId) < 1) {
      throw new Error("itemId param is not correct");
    }

    if (typeof modifiers === "undefined" || typeof modifiers !== "object") {
      throw new Error("modifiers param is not correct");
    }

    const { results } = await q(
      "INSERT INTO basket_item (`menu_item_id`, `qty`) values (?, ?);",
      [itemId, qty]
    );

    const basketItemId = results.insertId;

    const mods = Object.keys(modifiers).map((mId) => [
      Number(mId),
      modifiers[mId],
      basketItemId
    ]);

    console.log(mods, mods.length);

    if (mods.length) {
      await q(
        "INSERT INTO basket_item_modifier (`menu_item_id`, `qty`, `basket_item_id`) values ?;",
        [mods]
      );
    }

    res.end();
  } catch (error) {
    console.log(error);
    res.status(400).json({ error: error.message });
  }
});

const productCategoriesQuery = `
  select
    menu_category.id as "cId", 
    menu_item.id as "pId" 
  from menu_item 
  inner join menu_item_categories on 
    menu_item_categories.menu_item_id = menu_item.id 
  inner join menu_category on 
    menu_item_categories.menu_category_id = menu_category.id 
;`;

app.get("/api/restarauntData", async (req, res) => {
  try {
    const data = {
      categoriesById: {},
      productsById: {},
      categories: []
    };

    const { results: categories } = await q("SELECT * FROM `menu_category`;");
    const { results: products } = await q("SELECT * FROM `menu_item`;");
    const { results: productCategories } = await q(productCategoriesQuery);

    categories.forEach((c) => {
      c.items = [];
      data.categoriesById[c.id] = c;

      if (c.top_level) {
        data.categories.push(c.id);
      }
    });

    products.forEach((p) => {
      p.modifiers = [];
      data.productsById[p.id] = p;

      data.categoriesById[p.menu_category_id].items.push(p.id);
    });

    productCategories.forEach(({ cId, pId }) => {
      data.productsById[pId].modifiers.push(cId);
    });

    res.json(data);
  } catch (e) {
    console.log(e);
    res.status(400).end();
  }
});

(async () => {
  try {
    await q(sql_data);

    app.listen(PORT, () => {
      console.log(`app is running at ${PORT}`);
    });
  } catch (e) {
    console.log(e);
  }
})();
