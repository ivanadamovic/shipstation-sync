const handleResponse = (response) =>
  response.text().then((text) => {
    const data = text && JSON.parse(text);
    if (!response.ok) {
      if (response.status === 401) {
      }

      const error = (data && data.message) || response.statusText;
      return Promise.reject({ error, message: data.error });
    }

    return data;
  });

export const request = {
  handleResponse,
};
