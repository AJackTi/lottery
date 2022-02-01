const HDWalletProvider = require('truffle-hdwallet-provider')
const Web3 = require('web3')
const {abi, bytecode} = require('./compile')

const provider = new HDWalletProvider(
    'update employ cost drill wedding book decade blade skill man good wall',
    'https://rinkeby.infura.io/v3/947fd5efaefd4c61848146c53b269185'
)

const web3 = new Web3(provider)

const deploy = async () => {
    const accounts = await web3.eth.getAccounts()

    console.log('Attempting to deploy from account', accounts)

    const result = await new web3.eth.Contract(abi)
        .deploy({data: bytecode})
        .send({gas: '1000000', from: accounts[0]})

    console.log('Contract deployed to ', result.options.address)
}

deploy()
