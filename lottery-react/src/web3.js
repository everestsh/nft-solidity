import Web3 from "web3";

console.log('11111111!');

const web3 = new Web3(window.ethereum);
var account_global
const accounts = window.ethereum.request({ method: 'eth_requestAccounts' }); // Waits for connection to MetaMask.
account_global = accounts[0];
// if (typeof window.ethereum == 'undefined') {
//     console.log('MetaMask is installed!');
// }
console.log(accounts)
console.log('222222!');
// ethereum.request({ method: "eth_requestAccounts" });



export default web3;
