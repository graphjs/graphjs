module.exports = {

    /**
     * @param {string} str
     */
    decode: function (str) {

        var regex = /\n\[metadata\]\(type=(?<type>[a-zA-Z0-9_-]*?);key=\{(?<key>[^\\{}]*(?:\\[^][^\\{}]*)*)\};value=\{(?<value>[^\\{}]*(?:\\[^][^\\{}]*)*)\}\)/g;

        var metadata = [];
        var foundIndex = str.search(regex);

        while ((matches = regex.exec(str)) !== null) {
            metadata.push({
                type: matches.groups.type,
                key: matches.groups.key.replace(/\\\{/g, '{').replace(/\\\}/g, '}').replace(/\\\\/g, '\\'),
                value: matches.groups.value.replace(/\\\{/g, '{').replace(/\\\}/g, '}').replace(/\\\\/g, '\\'),
            });
        }

        return {
            content: foundIndex === -1 ? str : str.substring(0, foundIndex),
            metadata,
        };
    },

    /**
     * @param {object} str
     */
    encode: function (parsed) {
        var content = parsed.content;
        var metadata = parsed.metadata;
        var metastr = metadata.map(function (meta) {
            var type = meta.type;
            var key = meta.key.replace(/\\/g, '\\\\').replace(/\{/g, '\\{').replace(/\}/g, '\\}');
            var value = meta.value.replace(/\\/g, '\\\\').replace(/\{/g, '\\{').replace(/\}/g, '\\}');
            return `[metadata](type=${type};key={${key}};value={${value}})`;
        }).join('\n');

        return [ content, ...(metastr ? [ metastr ] : []) ].join('\n');
    },
};

