// deploy code will go here
const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3')
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'REPLACE_WITH_YOUR_MNEMONIC',
    // remember to change this to your own phrase!
    'https://rinkeby.infura.io/v3/1a36a3d9d9a44c73ac2eb0bf7e221aa7'
)
const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from account', accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({ data: bytecode, arguments: ['Hi there!']})
        .send({ from: accounts[0], gas: '1000000'})
    
    console.log('Contract deployed to', result.options.address);
}
deploy();