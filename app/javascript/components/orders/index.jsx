import React, { Component } from 'react'
import {
  Card,
  ResourceList,
  ResourceItem,
  TextStyle,
} from '@shopify/polaris'

class OrderList extends Component {
  constructor(props) {
    super(props)

    this.state = {
      orders: [
        {
          id: 2951502135435,
          orderNumber: '234903',
          shipDate: '2021-02-03',
        },
      ],
      selectedOrders: []
    }
  }

  componentDidMount() {
  }

  selectOrders = (selectedOrders) => {
    this.setState({ selectedOrders })
  }

  renderItem = (item) => {
    const {id, orderNumber, shipDate} = item
    return (
      <ResourceItem
        id={id}
        accessibilityLabel={`View details for ${orderNumber}`}
        persistActions
      >
        <h3>
          <TextStyle variation="strong">{orderNumber}</TextStyle>
        </h3>
        <div>{shipDate}</div>
      </ResourceItem>
    )
  }

  render() {
    const resourceName = {
      singular: 'order',
      plural: 'orders',
    }

    const promotedBulkActions = [
      {
        content: 'Download PDF',
        onAction: () => console.log('Todo: implement bulk edit'),
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
