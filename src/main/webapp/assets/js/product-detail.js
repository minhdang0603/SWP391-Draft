// Hàm định dạng số tiền VND
function formatCurrency(amount) {
    return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// Iterate over each product to format the price
document.querySelectorAll('.product-price').forEach(function (element) {
    var price = parseFloat(element.textContent.replace(/[^\d.-]/g, '')); // Extract the numerical value from the price element
    element.innerText = formatCurrency(price) + ' đ'; // Format the price and set it back to the element
});

document.addEventListener('DOMContentLoaded', (event) => {
    const ratingElement = document.querySelector('.product-rating');
    const averageRating = parseFloat(ratingElement.getAttribute('data-average-rating'));
    // Select all review rating elements
    const reviewRatingElements = document.querySelectorAll('[class^="review-rating-"]');

    // Calculate the number of full, half, and empty stars
    const fullStars = Math.floor(averageRating);
    const halfStars = (averageRating - fullStars) >= 0.5 ? 1 : 0;
    const emptyStars = 5 - fullStars - halfStars;

    // Clear existing stars
    ratingElement.innerHTML = '';

    // Append full stars
    for (let i = 0; i < fullStars; i++) {
        ratingElement.innerHTML += '<i class="fa fa-star"></i>';
    }

    // Append half star if needed
    if (halfStars === 1) {
        ratingElement.innerHTML += '<i class="fa fa-star-half-o"></i>';
    }

    // Append empty stars
    for (let i = 0; i < emptyStars; i++) {
        ratingElement.innerHTML += '<i class="fa fa-star-o"></i>';
    }

    // Iterate over each review rating element
    reviewRatingElements.forEach(function (element) {
        // Get the rating score from data attribute
        const ratingScore = parseFloat(element.getAttribute('data-rating-score'));

        // Calculate the number of full, half, and empty stars
        const fullStars = Math.floor(ratingScore);
        const halfStar = (ratingScore - fullStars) >= 0.5;
        const emptyStars = 5 - Math.ceil(ratingScore);

        // Clear existing stars
        element.innerHTML = '';

        // Append full stars
        for (let i = 0; i < fullStars; i++) {
            element.innerHTML += '<i class="fa fa-star"></i>';
        }

        // Append half star if needed
        if (halfStar) {
            element.innerHTML += '<i class="fa fa-star-half-o"></i>';
        }

        // Append empty stars
        for (let i = 0; i < emptyStars; i++) {
            element.innerHTML += '<i class="fa fa-star-o empty"></i>';
        }
    });


    const ratingData = extractRatingData();
    updateRating(ratingData);
});

function updateRating(ratingData) {
    const ratingSpan = document.getElementById('avg-rating');
    const ratingStars = document.getElementById('avg-stars');
    const ratingScore = parseFloat(ratingSpan.textContent);
    const productRating = document.querySelector(".product-rating");

    const fullStars = Math.floor(ratingScore);
    const halfStar = ratingScore % 1 !== 0;
    const starElements = ratingStars.children;

    for (let i = 0; i < starElements.length; i++) {
        if (i < fullStars) {
            starElements[i].className = 'fa fa-star';
        } else if (i === fullStars && halfStar) {
            starElements[i].className = 'fa fa-star-half-o';
        } else {
            starElements[i].className = 'fa fa-star-o';
        }
    }

    const ratingElements = document.querySelectorAll('.rating li');

    ratingElements.forEach(element => {
        const rating = parseInt(element.getAttribute('data-rating'));
        const ratingCount = ratingData[rating] || 0;
        const totalRatings = Object.values(ratingData).reduce((a, b) => a + b, 0);
        const percentage = totalRatings ? (ratingCount / totalRatings) * 100 : 0;

        const progressBar = element.querySelector('.rating-progress > div');
        progressBar.style.width = percentage + '%';

        const sumSpan = element.querySelector('.sum');
        sumSpan.textContent = ratingCount;
    });
}

function extractRatingData() {
    const ratingElements = document.querySelectorAll('.rating li');
    const ratingData = {};

    ratingElements.forEach(element => {
        const rating = parseInt(element.getAttribute('data-rating'));
        ratingData[rating] = parseInt(element.querySelector('.sum').textContent);
    });

    return ratingData;
}