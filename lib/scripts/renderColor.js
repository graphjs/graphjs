import less from 'less';

const colorFunction = '@prefix: graphjs;\n' +
'.icon-color-states(@color) {\n' +
'    svg {\n' +
'        path {\n' +
'            fill: @color;\n' +
'        }\n' +
'    }\n' +
'    &:hover {\n' +
'        svg {\n' +
'            path {\n' +
'                fill: tint(@color, 10%);\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    &:active {\n' +
'        svg {\n' +
'            path {\n' +
'                fill: shade(@color, 10%);\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'}\n' +
'.text-color-states(@color) {\n' +
'    color: @color;\n' +
'    &:hover {\n' +
'        color: tint(@color, 10%);\n' +
'    }\n' +
'    &:active {\n' +
'        color: shade(@color, 10%);\n' +
'    }\n' +
'}\n' +
'.background-color-states(@color) {\n' +
'    background-color: @color;\n' +
'    &:hover {\n' +
'        background-color: tint(@color, 10%);\n' +
'    }\n' +
'    &:active {\n' +
'        background-color: shade(@color, 10%);\n' +
'    }\n' +
'}\n' +
'.@{prefix}-custom-color {\n' +
'    .@{prefix}-root {\n' +
'        a {\n' +
'            .text-color-states(@primary-color);\n' +
'        }\n' +
'        button {\n' +
'            .background-color-states(@primary-color);\n' +
'        }\n' +
'    }\n' +
'    .@{prefix}-article {' +
'        a {' +
'            color: @primary-color;' +
'        }' +
'        blockquote {' +
'            border-left-color: @primary-color;' +
'            &::before{' +
'                color: @primary-color;' +
'            }' +
'        }' +
'    }' +
'    .@{prefix}-box.@{prefix}-root {\n' +
'        .@{prefix}-header {\n' +
'            .@{prefix}-title {\n' +
'                color: @primary-color;\n' +
'            }\n' +
'            .@{prefix}-option {\n' +
'                .icon-color-states(@primary-color);\n' +
'                svg {\n' +
'                    path {\n' +
'                        fill: @primary-color;\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    .@{prefix}-card.@{prefix}-root {\n' +
'        .@{prefix}-information {\n' +
'            b {\n' +
'                .text-color-states(@primary-color);\n' +
'            }\n' +
'        }\n' +
'        button {\n' +
'            .background-color-states(@primary-color);\n' +
'        }\n' +
'        &.@{prefix}-color {\n' +
'            background-color: @primary-color;\n' +
'            button {\n' +
'                color: @primary-color;\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    .@{prefix}-credit {\n' +
'        span {\n' +
'            color: @primary-color;\n' +
'            b {\n' +
'                color: @primary-color;\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    .@{prefix}-loading {\n' +
'        .@{prefix}-loader {\n' +
'            &.@{prefix}-inline {\n' +
'                .@{prefix}-dots {\n' +
'                    & > span {\n' +
'                        background-color: @primary-color;\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-alert.@{prefix}-root {\n' +
'        & > button {\n' +
'            &:not(.@{prefix}-danger) {\n' +
'               color: @primary-color !important;\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-auth-state.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            a {\n' +
'                color: @primary-color;' +
'                border-right: 1px dotted fade(@primary-color, 20%);\n' +
'            }\n' +
'            .@{prefix}-logged {\n' +
'                .@{prefix}-details {\n' +
'                    span {\n' +
'                        color: @primary-color;\n' +
'                    }\n' +
'                }\n' +
'                .@{prefix}-exit {\n' +
'                    svg {\n' +
'                        path {\n' +
'                            fill: fade(@primary-color, 50%);\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'        &.@{prefix}-color {\n' +
'            background-color: @primary-color;\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-blog-composer.@{prefix}-root {' +
'        .@{prefix}-content {' +
'            form {' +
'                input, input[type] {' +
'                    color: @primary-color;' +
'                    &::placeholder {' +
'                        color: @primary-color;' +
'                    }' +
'                }' +
'            }' +
'        }' +
'    }' +
'    @{prefix}-blog-list.@{prefix}-root {' +
'        .@{prefix}-content {' +
'            .@{prefix}-list {' +
'                .@{prefix}-item {' +
'                    .@{prefix}-title {' +
'                        .text-color-states(@primary-color);' +
'                    }' +
'                }' +
'            }' +
'        }' +
'    }' +
'    @{prefix}-blog-post.@{prefix}-root {' +
'        .@{prefix}-content {' +
'            .@{prefix}-post {' +
'                .@{prefix}-title {' +
'                    color: @primary-color;' +
'                }' +
'            }' +
'            .@{prefix}-reply {' +
'                border-top: 2px solid @primary-color;' +
'                .@{prefix}-synopsis {' +
'                    & > a {' +
'                        &.@{prefix}-icon {' +
'                            svg {' +
'                                path {' +
'                                    fill: @primary-color;' +
'                                }' +
'                            }' +
'                        }' +
'                    }' +
'                }' +
'            }' +
'        }' +
'    }' +
'    @{prefix}-forum-list.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            .@{prefix}-bar {\n' +
'                .@{prefix}-search {\n' +
'                    background-color: desaturate(tint(@primary-color, 20%), 5%);\n' +
'                }\n' +
'                button {\n' +
'                    .background-color-states(@primary-color);\n' +
'                }\n' +
'            }\n' +
'            .@{prefix}-list {\n' +
'                .@{prefix}-item {\n' +
'                    &:hover {\n' +
'                        background-color: fade(@primary-color, 5%);\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-forum-thread.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            .@{prefix}-reply {\n' +
'                border-top: 2px solid @primary-color;\n' +
'                .@{prefix}-synopsis {\n' +
'                    & > a {\n' +
'                        &.@{prefix}-icon {\n' +
'                            svg {\n' +
'                                path {\n' +
'                                    fill: @primary-color;\n' +
'                                }\n' +
'                            }\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-group-card.@{prefix}-root {\n' +
'        .@{prefix}-information {\n' +
'            b {\n' +
'                color: @primary-color;\n' +
'                .text-color-states(@primary-color);\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-group-header.@{prefix}-root {\n' +
'        .@{prefix}-information {\n' +
'            a {\n' +
'                .text-color-states(@primary-color);\n' +
'            }\n' +
'            .@{prefix}-members {\n' +
'                span {\n' +
'                    background-color: @primary-color;\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'        ul {\n' +
'            li {\n' +
'                a {\n' +
'                    svg {\n' +
'                        path {\n' +
'                            fill: @primary-color;\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-group-settings.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            h2 {\n' +
'                color: @primary-color;\n' +
'            }\n' +
'            .@{prefix}-cover {\n' +
'                &:hover {\n' +
'                    &::before {\n' +
'                        background-color: fade(@primary-color, 90%);\n' +
'                    }\n' +
'                }\n' +
'                &::before {\n' +
'                    background-color: fade(@primary-color, 60%);\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-messages.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            .@{prefix}-sidebar {\n' +
'                input, input[type] {\n' +
'                    background-color: @primary-color;\n' +
'                }\n' +
'                .@{prefix}-list {\n' +
'                    .@{prefix}-item {\n' +
'                        &.@{prefix}-unread {\n' +
'                            background-color: fade(@primary-color, 15%);\n' +
'                            div {\n' +
'                                b {\n' +
'                                    color: @primary-color !important;\n' +
'                                }\n' +
'                            }\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'            .@{prefix}-main {\n' +
'                .@{prefix}-conversation {\n' +
'                    .@{prefix}-item {\n' +
'                        &.@{prefix}-outbound {\n' +
'                            p {\n' +
'                                background-color: @primary-color;\n' +
'                            }\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-profile-activity.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            ul {\n' +
'                li {\n' +
'                    &::before {\n' +
'                        background-color: @primary-color;\n' +
'                    }\n' +
'                    div {\n' +
'                        svg {\n' +
'                            path {\n' +
'                                fill: @primary-color;\n' +
'                            }\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-profile-card.@{prefix}-root {\n' +
'        .@{prefix}-option {\n' +
'            .icon-color-states(@primary-color);\n' +
'            svg {\n' +
'                path {\n' +
'                    fill: @primary-color;\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'        .@{prefix}-information {\n' +
'            b {\n' +
'                .text-color-states(@primary-color);\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-profile-header.@{prefix}-root {\n' +
'        .@{prefix}-option {\n' +
'            .icon-color-states(@primary-color);\n' +
'            svg {\n' +
'                path {\n' +
'                    fill: @primary-color;\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'        .@{prefix}-information {\n' +
'            a {\n' +
'                .text-color-states(@primary-color);\n' +
'            }\n' +
'        }\n' +
'        ul {\n' +
'            li {\n' +
'                a {\n' +
'                    svg {\n' +
'                        path {\n' +
'                            fill: @primary-color;\n' +
'                        }\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-profile-settings.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            h2 {\n' +
'                color: @primary-color;\n' +
'            }\n' +
'            .@{prefix}-avatar {\n' +
'                &:hover {\n' +
'                    &::before {\n' +
'                        background-color: fade(@primary-color, 90%);\n' +
'                    }\n' +
'                }\n' +
'                &::before {\n' +
'                    background-color: fade(@primary-color, 60%);\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'    @{prefix}-star-list.@{prefix}-root {\n' +
'        .@{prefix}-content {\n' +
'            .@{prefix}-bar {\n' +
'                .@{prefix}-search {\n' +
'                    background-color: desaturate(tint(@primary-color, 20%), 5%);\n' +
'                }\n' +
'            }\n' +
'            .@{prefix}-list {\n' +
'                .@{prefix}-item {\n' +
'                    &:hover {\n' +
'                        background-color: fade(@primary-color, 5%);\n' +
'                    }\n' +
'                }\n' +
'            }\n' +
'        }\n' +
'    }\n' +
'}\n';

export default function(color) {
    less.render(colorFunction.toString(), {
    	modifyVars: {
    		'@primary-color': color
    	}
    }, function(event, output) {
    	let body = document.body || document.getElementsByTagName('body')[0];
    	body.classList.add('graphjs-custom-color');
    	let head = document.head || document.getElementsByTagName('head')[0];
    	let style = document.createElement('style');
    	style.type = 'text/css';
    	if (style.styleSheet){
    		style.styleSheet.cssText = output.css;
    	} else {
    		style.appendChild(document.createTextNode(output.css));
    	}
    	head.appendChild(style);
    });
};