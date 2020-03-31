pragma solidity ^0.4.17;
pragma experimental ABIEncoderV2;
contract ContractDeployer {

    address[] public deployedContracts;
        function createContract(address _reciever, string info_string,string filehash) public {
        if(_reciever!=msg.sender){
        address newContract = new MyContract( _reciever , info_string,msg.sender,filehash);
        deployedContracts.push(newContract);
        }
    }
    function getDeployedContracts() public view returns (address[]){
        return deployedContracts;
    }
    function getNumberofContracts() public view returns (uint) {
        return deployedContracts.length;
    }
}

contract MyContract {
    address public manager;
    address reciever;
    bool public isAccepted;
    string public contract_info;
    string[] public msgFromReceiver;
    string[] public msgFromManager;
    string public filehash;
    constructor(address _reciever, string info_string,address Contract_manager,string _filehash) public {
        manager = Contract_manager;
        reciever = _reciever;
        contract_info=info_string;
        filehash = _filehash;
        isAccepted = false;
        }

    function getManagerAddress() public view returns(address){
      return manager;
    }
    function getReceiverAddress() public view returns(address)
    {
      return reciever;
    }
    function getfilehash() public view returns(string){
      return filehash;
    }
    function setfilehash(string hash) public {
      filehash=hash;
    }
    function acceptRequest() public{
        require(msg.sender == reciever);
        isAccepted = true;
    }
    function checkAccepted() public view returns(bool){
      return isAccepted;
    }

    function setMsgfromReceiver(string msgReceiver) public {
        require(msg.sender==reciever&&!isAccepted);
        msgFromReceiver.push(msgReceiver);
    }

    function getmsgFromReceiver() public view returns(string[]){
      return msgFromReceiver;
    }

    function setMsgfromManager(string msgManager) public {
        require(msg.sender==manager&&!isAccepted);
        msgFromManager.push(msgManager);
    }
    function getmsgFromManager() public view returns(string[]){
      return msgFromManager;
    }
    function setContract_Info(string s) public{
        require(msg.sender==manager&&!isAccepted);
        contract_info=s;
    }
    function getSummary() public view returns(address,string,address,string
      ){
        return(
          reciever,contract_info,manager,filehash
          );
    }
}
