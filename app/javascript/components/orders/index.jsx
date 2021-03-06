import React, { Component } from 'react'
import {
  Card,
  ResourceList,
  ResourceItem,
  TextStyle,
  Icon,
  rgbString
} from '@shopify/polaris'
import {
  ShipmentMajor
} from '@shopify/polaris-icons';
import moment from 'moment'
import { orderService } from '../../services'

class OrderList extends Component {
  constructor(props) {
    super(props)

    this.state = {
      orders: [],
      selectedOrders: []
    }
  }

  componentDidMount() {
    orderService.getOrders()
      .then(res => {
        const orders = res.orders

        this.setState({ orders })
      })
      .catch(err => {
        console.log(`getOrders error -- err`)
      })
  }

  selectOrders = (selectedOrders) => {
    this.setState({ selectedOrders })
  }

  renderItem = (item) => {
    const {id, order_number, order_date, ship_date} = item
    const shipmentIcon = <Icon source={ShipmentMajor} />;

    return (
      <ResourceItem
        id={id}
        accessibilityLabel={`View details for ${order_number}`}
        media={shipmentIcon}
        persistActions
      >
        <h3>
          <TextStyle variation="strong">{order_number}</TextStyle>
        </h3>
        <div>Order date: {moment(order_date).format('MM/DD/YYYY')}</div>
        <div>Shipment date: {moment(ship_date).format('MM/DD/YYYY')}</div>
      </ResourceItem>
    )
  }

  // Trigger generate event
  handleGenerate = () => {
    this.generatorTimer = setInterval(this.generatePdf, 1000)
  }

  // Generate PDF
  generatePdf = () => {
  }

  // Archive orders
  handleArchive = () => {
    const { selectedOrders } = this.state

    orderService.archiveOrders(selectedOrders)
      .then(res => {
        this.setState({ orders: res.orders, selectOrders: [] })
      })
      .catch(err => {
        console.log(`archiveOrders error -- err`)
      })
  }

  render() {
    const resourceName = {
      singular: 'order',
      plural: 'orders',
    }

    const promotedBulkActions = [
      {
        content: 'Generate PDF',
        onAction: () => this.handleGenerate(),
      },
      {
        content: 'Archive orders',
        onAction: () => this.handleArchive(),
      },
    ]

    const {
      orders,
      selectedOrders
    } = this.state

    return (
      <Card>
        <ResourceList
          resourceName={resourceName}
          items={orders}
          renderItem={this.renderItem}
          selectedItems={selectedOrders}
          onSelectionChange={this.selectOrders}
          promotedBulkActions={promotedBulkActions}
        />
      </Card>
    )
  }
}

export default OrderList
