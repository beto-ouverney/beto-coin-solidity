pragma solidity ˆ0.8.0;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount ) external retunrs (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract BetoCoin is IERC20 {

    string public constant name = "Beto Coin";
    string public constant symbol = "BETO";
    uint8 public constant decimals = 18;

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;

    uint256 totalSupply_ = 10 ether;

    constructor() {
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address coinOwner) public override view returns (uint256) {
        return balances[coinOwner];
    }

    function transfer(address receiver, uint256  numCoins) public override returns (bool) {
        require(numCoins <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - numCoins;
        balances[receiver] = balances[receiver] + numCoins;
        emit Transfer(msg.sender, receiver, numCoins);
        return true;
    }

    function approve (address delegate, uint256 numCoins) public override returns (bool) {
        allowed[msg.sender][delegate] = numCoins;
        emit Approval(msg.sender, delegate, numCoins);
        return true;
    }

    function allowance (address owner, address delegate) public override view returns (uint256) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numCoins) public override returns (bool) {
        require(numCoins <= balances[owner]);
        require(numCoins <= allowed[owner][msg.sender]);
        
        balances[owner] = balances[owner] - numCoins;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numCoins;
        balances[buyer] = balances[buyer] + numCoins;
        emit Transfer(owner, buyer, numCoins);
        return true;
    }

}