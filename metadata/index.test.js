const assert = require('assert');
const metadata = require('.');

describe('metadata', function () {

    var dataSamples = [
        {
            encoded: 'Nice Video [video](http://example.com/video{1123}.mp4)'
                + '\n[metadata](type=video-preview;key={http://example.com/video\\{1123\\}.mp4};value={http://example.com/video\\{1123\\}-preview.jpg})',
            decoded: {
                content: 'Nice Video [video](http://example.com/video{1123}.mp4)',
                metadata: [
                    {
                        type: 'video-preview',
                        key: 'http://example.com/video{1123}.mp4',
                        value: 'http://example.com/video{1123}-preview.jpg',
                    },
                ],
            },
        },

        // content without metadata
        {
            encoded: 'content without metadata',
            decoded: {
                content: 'content without metadata',
                metadata: [],
            },
        },

        // characters to be escaped (\,{,}) are escaped correctly
        {
            encoded: '\n[metadata](type=lorem_ipsum;key={\\{lorem\\}};value={\\\\ipsum\\\\})',
            decoded: {
                content: '',
                metadata: [
                    {
                        type: 'lorem_ipsum',
                        key: '{lorem}',
                        value: '\\ipsum\\',
                    },
                ],
            },
        },

        // multiple metadata
        {
            encoded: 'Some content '
                + '\n[metadata](type=file-size;key={http://www.example.org/image.jpg};value={123})'
                + '\n[metadata](type=original-filename;key={http://www.example.net/image.gif};value={sample.gif})',
            decoded: {
                content: 'Some content ',
                metadata: [
                    {
                        type: 'file-size',
                        key: 'http://www.example.org/image.jpg',
                        value: '123',
                    },
                    {
                        type: 'original-filename',
                        key: 'http://www.example.net/image.gif',
                        value: 'sample.gif',
                    },
                ],
            },
        },

        // escaped closing bracket is present but no unescaped closing bracket
        {
            encoded: '\n[metadata](type=invalid;key={\\};value={\\})',
            decoded: {
                content: '\n[metadata](type=invalid;key={\\};value={\\})',
                metadata: [],
            },
        },

        // key, value are not enclosed in curly braces
        {
            encoded: '\n[metadata](type=invalid;key=abc;value=xyz)',
            decoded: {
                content: '\n[metadata](type=invalid;key=abc;value=xyz)',
                metadata: [],
            },
        },
    ];

    describe('decode', function () {
        dataSamples.forEach(function (dataSample, index) {
            it(`converts encoded into decoded for data set #${index}`, function () {
                assert.deepStrictEqual(metadata.decode(dataSample.encoded), dataSample.decoded);
            });
        });
    });

    describe('encode', function () {
        dataSamples.forEach(function (dataSample, index) {
            it(`converts decoded into encoded for data set #${index}`, function () {
                assert.deepStrictEqual(metadata.encode(dataSample.decoded), dataSample.encoded);
            });
        });
    });

});

