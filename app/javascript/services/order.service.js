// Order service

import { request } from "../utils";
import { orderConstants } from "../constants"

const headers = { "Content-Type": "application/json" }
const apiVersion = orderConstants.API_VERSION

const getOrders = () => {
  return fetch(`${apiVersion}/orders`, {
    method: 'GET',
    headers: headers
  })
  .then(request.handleResponse)
  .then((res) => res)
}

const archiveOrders = (orders) => {
  return fetch(`${apiVersion}/orders/archive`, {
    method: 'POST',
    headers: headers,
    body: JSON.stringify({ ids: orders })
  })
  .then(request.handleResponse)
  .then((res) => res)
}

export const orderService = {
  getOrders,
  archiveOrders
}
