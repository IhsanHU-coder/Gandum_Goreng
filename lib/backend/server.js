const express = require("express");
const cors = require("cors");
const midtransClient = require("midtrans-client");

const app = express();
app.use(cors());
app.use(express.json());

app.post("/create-transaction", async (req, res) => {
  const snap = new midtransClient.Snap({
    isProduction: false,
    serverKey: "Mid-server-Kt-kEIrgnCl02OkgjT0f3MTG", // sandbox
  });

  const parameter = {
    transaction_details: {
      order_id: req.body.order_id,
      gross_amount: req.body.gross_amount,
    },
    item_details: [
      {
        id: req.body.item_id || "ITEM-1",
        price: req.body.gross_amount,
        quantity: 1,
        name: req.body.item_name,
      },
    ],
  };

  // ⬇️ TAMBAH customer_details HANYA JIKA ADA
  if (req.body.email) {
    parameter.customer_details = {
      email: req.body.email,
    };
  }

  try {
    const transaction = await snap.createTransaction(parameter);
    res.json({
      token: transaction.token,
      redirect_url: transaction.redirect_url,
    });
  } catch (e) {
    res.status(500).json({
      error: e.message,
    });
  }
});

app.listen(3000, "0.0.0.0", () => {
  console.log("Server running on port 3000");
});
