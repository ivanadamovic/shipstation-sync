// Order service

import { request } from "../utils";

const headers = { "Content-Type": "application/json" }

const getOrders = () => {
  return fetch('/api/v1/orders', {
    method: 'GET',
    headers: headers
  })
  .then(request.handleResponse)
  .then((res) => res)
}

export const orderService = {
  getOrders
}
