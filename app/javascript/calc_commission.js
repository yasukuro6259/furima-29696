function calc_commission_profit (){
const price = document.getElementById("item-price").value;
const commission_price = Math.floor(price * 0.1);
const profit_price = (price - commission_price);
const tax = document.getElementById("add-tax-price");
const profit = document.getElementById("profit")
tax.innerHTML = commission_price;
profit.innerHTML = profit_price;
};
// setInterval(calc_commission_profit, 100);
