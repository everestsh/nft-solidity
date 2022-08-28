import Web3 from "web3";
window.ethereum.request({ method: "eth_requestAccounts" });
if (typeof window.ethereum !== 'undefined') {
    console.log('MetaMask is installed!');
}
const web3 = new Web3(window.ethereum);

export default web3;