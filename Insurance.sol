//SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
contract Insurance{
    /** 
     * Defined two structs
     * 
     * 
     */
    struct Product {
        uint productId;
        string productName;
        uint price;
        bool offered;
        address ProductOwnerAddress;
        address buyerAddress;
    }
    struct Client {
        bool isValid;
        uint time;
    }
    
    event productLoaded(uint productId,string productName, uint price,bool offered);
    
    mapping (uint256 => address) public _owners;
    mapping(address => uint256) public _balances;
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    uint productCounter;
    address payable insOwner;
    
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
        Product memory NewProduct = Product (_productId , _productName , _price , true, msg.sender, address(0));
        productCounter++;
        productIndex [productCounter ++] = NewProduct;
        emit productLoaded(_productId,_productName,_price,true);
    }
    function doNotOffer(uint _productIndex) public returns(bool) {
        require(msg.sender == insOwner,"No Offer");
        return productIndex[_productIndex].offered = false;
    }
    function forOffer(uint _productIndex) public returns(bool) {
        require(msg.sender == insOwner,"Yes Offer");
        return productIndex[_productIndex].offered = true;

    }
    function changePrice(uint _productIndex, uint _price) public view {
        require( productIndex[_productIndex].price>=1);
        productIndex[_productIndex].price==_price;
    }
    function balanceOf(address _insOwner) public view  returns(uint256) {
        require(_insOwner != address(0));
        return _balances[insOwner];
        
    }
    /**
    *@dev 
    * Every client buys an insurance, 
    * you need to map the client's address to the id of product to struct client, using (client map)
    */
    
    function buyInsurance(uint _productIndex) public payable {
        require(productIndex[_productIndex].price == msg.value ,"Not correct");
        Client memory NewClient;
        NewClient.isValid=true;
        NewClient.time = block.number;
        client[msg.sender][_productIndex]= NewClient;
        
        payable(msg.sender).transfer(msg.value);
        
    } 
    function Fatch(uint _productId)public view returns(uint productId,string memory productName,uint price, bool offere ,address owner,address buyer){
      productId =productIndex [_productId].productId;
      productName =productIndex [_productId].productName;
      price = productIndex[_productId].price;
      offere = productIndex[_productId].offered;
      owner = productIndex[_productId].ProductOwnerAddress;
      buyer = productIndex[_productId].buyerAddress;  
    }
     function ownerOf(uint256 tokenId) public view  returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }
     function transferID( address to, uint256 tokenId) public  {
        //solhint-disable-next-line max-line-length
        require(ownerOf(tokenId) == msg.sender,"only owner" );
        require(to != address(0), "address to not 0 ");
        _transfer(msg.sender, to, tokenId);
    }
     function _transfer(address from, address to, uint256 tokenId) public  {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
    }
    
    function mint(address to , uint256 tokenId)public {
        require(to != address(0), "ERC721: mint to the zero address");
        _balances[to] += 1;
        _owners[tokenId] = to;
    }
     function _exists(uint256 tokenId) public view  returns (bool) {
        return _owners[tokenId] != address(0);
    }
     
    
}