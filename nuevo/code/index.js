const https = require('https')
const params = {
  host: process.env.ELB_ENDPOINT
}

exports.handler = (event, context, callback) => {

  let req = https.request(params, (res) => {
    console.log(' ---- DONE ---- ')
    console.log('STATUS CODE: ' + res.statusCode)
    console.log(' ---- DONE ---- ')
  })
  req.end()

  callback(null, 'great success')
}