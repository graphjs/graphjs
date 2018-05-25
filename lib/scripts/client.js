export function downsizeImage(path, width) {
	return path.replace('/upload/', '/upload/c_limit,w_' + width + '/')
};