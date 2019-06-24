const formatDate = utcDate => {
  if (utcDate) {
    let date = new Date(Date.parse(utcDate));
    let day = date.toLocaleString("en-us", {
      month: "short",
      day: "numeric",
      year: "numeric"
    });
    return day;
  } else {
    return "Invalid Date";
  }
};

const formatDateTime = utcDate => {
  if (utcDate) {
    let date = new Date(Date.parse(utcDate));
    let day = date.toLocaleString("en-us", {
      weekday: "short",
      month: "short",
      day: "numeric",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
      second: "2-digit"
    });
    return day;
  } else {
    return "Invalid Date";
  }
};

const dataMonthsChart = [
  { month: 1, count: 0 },
  { month: 2, count: 0 },
  { month: 3, count: 0 },
  { month: 4, count: 0 },
  { month: 5, count: 0 },
  { month: 6, count: 0 },
  { month: 7, count: 0 },
  { month: 8, count: 0 },
  { month: 9, count: 0 },
  { month: 10, count: 0 },
  { month: 11, count: 0 },
  { month: 12, count: 0 }
];

export { formatDate, formatDateTime, dataMonthsChart };
