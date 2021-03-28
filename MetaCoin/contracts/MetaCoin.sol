// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.7.0;

import "./ConvertLib.sol";


contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () public {
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract MetaCoin is Ownable {
    mapping (address => uint) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() public {
        balances[tx.origin] = 10000;
    }


  // function getBalanceInEth(address addr) public view returns(uint){
  //   return ConvertLib.convert(getBalance(addr),2);
  // }

    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }

  //РЕШЕНИЕ ЗАДАЧИ
  function buySomething() external payable {
      //тут декілька адресів в масиві, але нижче варіант з одним тільки
      //var requiredAdresses = ["0xDaF24b442f0Ef81ECA8533a368150D049D92334F", "0xBB03E001E89CD83Ddb4dc21A15814B2B03Db0F68"];
      address requiredAddress = 0xDaF24b442f0Ef81ECA8533a368150D049D92334F;
      require(msg.sender == requiredAddress, "Non-required address");
      require(msg.value == 0.001 ether, "Wrong sender amount");
      // Save user balance
      balances[msg.sender] = balances[msg.sender] + msg.value;
  }
  
  function withdraw(address payable _to) external onlyOwner {
      _to.transfer(address(this).balance);
  }
}
