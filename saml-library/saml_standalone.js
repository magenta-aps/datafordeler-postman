console.log(require('zlib').inflateRawSync(
    new Buffer(
        unescape(process.argv[2]),
        'base64'
    )
).toString('utf8'));
