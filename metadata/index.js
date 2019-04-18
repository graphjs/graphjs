module.exports = {

    /**
     * @param {string} str
     */
    decode: function (str) {

        var regex = /\n\[metadata\]\(type=([a-zA-Z0-9_-]*?)?;key=\{([^\\{}]*(?:\\[^][^\\{}]*)*)?\};value=\{([^\\{}]*(?:\\[^][^\\{}]*)*)?\}\)/g;

        var metadata = [];
        var foundIndex = str.search(regex);

        var matches;
        while ((matches = regex.exec(str)) !== null) {
            metadata.push({
                type: matches[1],
                key: matches[2].replace(/\\\{/g, '{').replace(/\\\}/g, '}').replace(/\\\\/g, '\\'),
                value: matches[3].replace(/\\\{/g, '{').replace(/\\\}/g, '}').replace(/\\\\/g, '\\'),
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
        content = content ? content : '';
        metastr = metastr ? '\n' + metastr : '';

        return content + metastr;
    },
};

