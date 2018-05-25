export function downsizeImage(path, width) {
	if(path.includes('cloudinary.com')) {
		return path.replace('/upload/', '/upload/c_limit,w_' + width + '/');
	} else {
		return path;
	}
};