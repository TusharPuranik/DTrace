pragma solidity ^0.6.0;

contract SupplyChain {
    
    event Added(uint256 index);
    
    struct State{
        string description;
        address person;
    }
    
    struct Product{
        address creator;
        string productName;
        string productType;
        string productQuantity;
        uint256 productId;
        string date;
        uint256 totalStates;
        mapping (uint256 => State) positions;
    }
    
    mapping(uint => Product) allProDTrace;
    uint256 items=0;
    
    function concat(string memory _a, string memory _b) public returns (string memory){
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }
    
    function newItem(string memory _text, string memory _productQuantity, string memory _productType ,string memory _date) public returns (bool) {
        Product memory newItem = Product({creator: msg.sender, totalStates: 0,productName: _text,productQuantity: _productQuantity, productType: _productType, productId: items, date: _date});
        allProDTrace[items]=newItem;
        items = items+1;
        emit Added(items-1);
        return true;
    }
    
    function addState(uint _productId, string memory info) public returns (string memory) {
        require(_productId<=items);
        
        State memory newState = State({person: msg.sender, description: info});
        
        allProDTrace[_productId].positions[ allProDTrace[_productId].totalStates ]=newState;
        
        allProDTrace[_productId].totalStates = allProDTrace[_productId].totalStates +1;
        return info;
    }
    
    function searchProduct(uint _productId) public returns (string memory) {

        require(_productId<=items);
        string memory output="Product Name: ";
        output=concat(output, allProDTrace[_productId].productName);
        output=concat(output, "<br>Product Quantity: ");
        output=concat(output, allProDTrace[_productId].productQuantity);
        output=concat(output, "<br>Product Type: ");
        output=concat(output, allProDTrace[_productId].productType);
        output=concat(output, "<br>Manufacture Date: ");
        output=concat(output, allProDTrace[_productId].date);
        
        for (uint256 j=0; j<allProDTrace[_productId].totalStates; j++){
            output=concat(output, allProDTrace[_productId].positions[j].description);
        }
        return output;
        
    }
    
}