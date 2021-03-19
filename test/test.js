const Insurance = artifacts.require("Insurance");

contract("Insurance", async function(accounts){

it (
    "should add a product", async function(){
        //let Product ID = 1;
        let instance = await Insurance.deployed()
        await instance.addProduct(1,"iphone",web3.utils.toWei('7', 'ether')) });

})
