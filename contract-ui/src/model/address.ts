export interface Address {
  id: number;
  street: string;
  city: string;
  zipcode: string;
  displayName: string;
}

export function newEmptyAddress(): Address {
  return {
    id: 0,
    street: "",
    city: "",
    zipcode: "",
    displayName: ""
  }
}
