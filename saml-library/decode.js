var saml_decode = function(token)
{
    // url -> base64 -> inflate
    result = require('zlib').inflateRawSync(
		new Buffer(
			unescape(token),
			'base64'
		)
	).toString('utf8');
    return result;
}

window.saml_decode = saml_decode;
