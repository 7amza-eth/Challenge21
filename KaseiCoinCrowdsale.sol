pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    constructor(uint rate, address payable wallet, KaseiCoin token) 
    public Crowdsale(rate, wallet, token) {}
}

contract KaseiCoinCrowdsaleDeployer {
    address public kaseiTokenAddress;
    address public kaseiCrowdsaleAddress;

    constructor(string memory name, string memory symbol, address payable wallet)
    public {
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        kaseiTokenAddress = address(token);

        KaseiCoinCrowdsale kaseinCrowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        kaseiCrowdsaleAddress = address(kaseinCrowdsale);
        
        token.addMinter(kaseiCrowdsaleAddress);
        token.renounceMinter(); 
    }
}